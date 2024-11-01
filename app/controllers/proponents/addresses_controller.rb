module Proponents
  class AddressesController < ApplicationController
    layout false

    before_action :set_proponent

    def new; end
    def show; end
    def edit; end

    def create
      @address = @proponent.create_address address_params

      if @address.save
        render :show
      else
        render :new
      end
    end

    def update
      @address = @proponent.address

      if @address.update(address_params)
        render :show
      else
        render :edit
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
