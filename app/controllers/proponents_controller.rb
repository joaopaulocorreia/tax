class ProponentsController < ApplicationController
  before_action :set_proponent, only: [:show, :edit, :update, :destroy]

  def index
    @proponents = Proponent.page(params[:page]).per(5)
  end

  def new
    @proponent = Proponent.new
  end

  def show; end
  def edit; end

  def create
    attributes = proponent_params.to_h
    @proponent = Proponent.new attributes
    return render :new, status: :unprocessable_entity unless @proponent.valid?

    service = Services::Proponent::CalculateTax.new
    service.call(proponent_params['salary'].to_f) do |m|
      m.success do |result|
        calculated_tax, tax_table = result

        attributes.store :tax, calculated_tax
        attributes.store :tax_table_id, tax_table.id
      end

      m.failure do
        return redirect_to new_proponent_path, alert: 'Error on calculate tax'
      end
    end

    service = Services::Proponent::Create.new
    service.call(attributes) do |m|
      m.success do |proponent|
        redirect_to proponent_path(proponent), notice: 'Proponent created with success'
      end

      m.failure do |proponent|
        @proponent = proponent
        render :new, status: :unprocessable_entity
      end
    end
  end

  def update
    attributes = proponent_params.to_h

    if attributes[:salary] != @proponent.salary
      UpdateTaxJob.perform_later(@proponent.id, attributes[:salary])
      attributes.delete :salary
    end

    service = Services::Proponent::Update.new
    service.with_step_args(update: [attributes]).call(params[:id]) do |m|
      m.success do |proponent|
        redirect_to proponent_path(proponent), notice: 'Proponent updated with success.'
      end

      m.failure :find_proponent do
        redirect_to proponents_path, alert: 'Record not found'
      end

      m.failure do |proponent|
        @proponent = proponent
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def destroy
    service = Services::Proponent::Destroy.new
    service.call(params[:id]) do |m|
      m.success do
        redirect_to proponents_path, notice: 'Proponent destroyed with success'
      end

      m.failure
    end
  end

  private

  def set_proponent
    @proponent = Proponent.find(params[:id])
  end

  def proponent_params
    params.require(:proponent).permit(:name, :cpf, :birthday, :salary, :tax, :tax_table_id)
  end
end
