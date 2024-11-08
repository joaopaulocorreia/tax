# frozen_string_literal: true

module Services
  module Proponent
    module Contact
      class Destroy < ApplicationService
        step :find_proponent
        step :destroy

        def find_proponent(id)
          proponent = ::Proponent.find_by(id:)

          if proponent
            Success proponent
          else
            Failure :record_not_found
          end
        end

        def destroy(proponent, contact_id)
          contact = proponent.contacts.find_by(id: contact_id)
          return Failure :record_not_found unless contact

          contact.destroy

          if contact.destroyed?
            Success contact
          else
            Failure :record_not_destroyed
          end
        end
      end
    end
  end
end
