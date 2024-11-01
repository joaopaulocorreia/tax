class ProponentsController < ApplicationController
  def index
    @proponents = Proponent.all
  end

  def new
    @proponent = Proponent.new
  end

  def show
    @proponent = Proponent.find(params[:id])
  end

  def create
    @proponent = Proponent.new proponent_params

    if @proponent.save
      redirect_to proponent_path(@proponent), notice: 'Proponent created with success'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def proponent_params
    params.require(:proponent).permit(:name, :cpf, :birthday)
  end
end
