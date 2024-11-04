module Proponents
  class ContactsController < ApplicationController
    before_action :set_proponent

    def new
      @contact = @proponent.contacts.new
      @contacts = @proponent.contacts.page(params[:page]).per(5)
    end

    def create
      @contacts = @proponent.contacts.page(params[:page]).per(5)

      service = Services::Proponent::Contact::Create.new
      service.with_step_args(create: [contact_params]).call(params[:proponent_id]) do |m|
        m.success do |contact|
          redirect_to new_proponent_contact_path(contact.proponent_id), notice: 'Contact created with success'
        end

        m.failure do |contact|
          @contact = contact
          render :new, status: :unprocessable_entity
        end
      end
    end

    def destroy
      service = Services::Proponent::Contact::Destroy.new
      service.with_step_args(destroy: [params[:id]]).call(params[:proponent_id]) do |m|
        m.success do |contact|
          redirect_to new_proponent_contact_path(params[:proponent_id]), notice: 'Contact destroyed with success'
        end

        m.failure do
          redirect_to new_proponent_contact_path(params[:proponent_id]), notice: 'Record not destroyed'
        end
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
