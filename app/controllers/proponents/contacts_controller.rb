module Proponents
  class ContactsController < ApplicationController
    before_action :set_proponent

    def new
      @contact = @proponent.contacts.new
    end

    def create
      @contact = @proponent.contacts.new contact_params

      if @contact.save
        redirect_to new_proponent_contact_path(@proponent), notice: 'Contact created with success'
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def set_proponent
      @proponent = Proponent.find params[:proponent_id]
    end

    def contact_params
      params.require(:contact).permit(:phone, :category)
    end
  end
end
