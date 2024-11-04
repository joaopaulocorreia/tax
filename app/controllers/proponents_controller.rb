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
    @proponent = Proponent.new proponent_params

    return render :new, status: :unprocessable_entity unless @proponent.valid?

    service = Services::Proponent::CalculateTax.new
    result = service.call(proponent_params['salary'].to_f)

    redirect_to new_proponent_path, alert: 'Proponent error' if result.failure?

    calculated_tax, tax_table = result.success

    attributes = proponent_params.to_h

    if calculated_tax <= 0
      attributes.store :tax, calculated_tax
      attributes.store :tax_table_id, tax_table.id
    end

    @proponent = Proponent.new attributes

    if @proponent.save
      redirect_to proponent_path(@proponent), notice: 'Proponent created with success'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    attributes = proponent_params.to_h

    if attributes[:salary] != @proponent.salary
      UpdateTaxJob.perform_later(@proponent.id, attributes[:salary])
      attributes.delete :salary
    end

    if @proponent.update(attributes)
      redirect_to proponent_path(@proponent), notice: 'Proponent updated with success. Salary will updated in background'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @proponent.destroy

    redirect_to proponents_path, notice: 'Proponent destroyed with success'
  end

  private

  def set_proponent
    @proponent = Proponent.find(params[:id])
  end

  def proponent_params
    params.require(:proponent).permit(:name, :cpf, :birthday, :salary, :tax, :tax_table_id)
  end
end
