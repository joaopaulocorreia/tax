# frozen_string_literal: true

module Proponents
  class AddressesController < ApplicationController
    before_action :set_proponent

    def new
      @address = @proponent.build_address
    end

    def show
      redirect_to new_proponent_address_path(@proponent) unless @proponent.address
      @address = @proponent.address
    end

    def edit
      redirect_to new_proponent_address_path(@proponent) unless @proponent.address
      @address = @proponent.address
    end

    def create
      service = Services::Proponent::Address::Create.new
      service.with_step_args(create: [address_params]).call(params[:proponent_id]) do |m|
        m.success do
          redirect_to proponent_address_path(params[:proponent_id]), notice: 'Address created with success'
        end

        m.failure do |address|
          @address = address
          render :new, status: :unprocessable_entity
        end
      end
    end

    def update
      service = Services::Proponent::Address::Update.new
      service.with_step_args(update: [address_params]).call(params[:proponent_id]) do |m|
        m.success do
          redirect_to proponent_address_path(params[:proponent_id]), notice: 'Address updated with success'
        end

        m.failure do |address|
          @address = address
          render :edit, status: :unprocessable_entity
        end
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
