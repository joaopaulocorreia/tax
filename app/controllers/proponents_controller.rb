class ProponentsController < ApplicationController
  before_action :set_proponent, only: [:show, :edit, :update]

  def index
    @proponents = Proponent.all
  end

  def new
    @proponent = Proponent.new
  end

  def show; end
  def edit; end

  def create
    @proponent = Proponent.new proponent_params

    if @proponent.save
      redirect_to proponent_path(@proponent), notice: 'Proponent created with success'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @proponent.update(proponent_params)
      redirect_to proponent_path(@proponent), notice: 'Proponent updated with success'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_proponent
    @proponent = Proponent.find(params[:id])
  end

  def proponent_params
    params.require(:proponent).permit(:name, :cpf, :birthday)
  end
end
