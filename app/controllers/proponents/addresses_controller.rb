module Proponents
  class AddressesController < ApplicationController
    before_action :set_proponent

    def new; end

    def show
      redirect_to new_proponent_address_path(@proponent) unless @proponent.address
    end

    def edit; end

    def create
      @address = @proponent.create_address address_params

      if @address.save
        redirect_to proponent_address_path(@proponent), notice: 'Address created with success'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      @address = @proponent.address

      if @address.update(address_params)
        redirect_to proponent_address_path(@proponent), notice: 'Address updated with success'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_proponent
      @proponent = Proponent.find params[:proponent_id]
    end

    def address_params
      params.require(:address).permit(:address, :number, :neighborhood, :city, :state, :postal_code)
    end
  end
end
