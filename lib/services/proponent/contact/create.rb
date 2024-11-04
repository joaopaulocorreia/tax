module Services
  module Proponent
    module Contact
      class Create < ApplicationService
        step :find_proponent
        step :create

        def find_proponent(id)
          proponent = ::Proponent.find_by(id:)

          if proponent
            Success OpenStruct.new(proponent:)
          else
            Failure :record_not_found
          end
        end

        def create(ctx, attributes)
          contact = ctx.proponent.contacts.new attributes

          if contact.save
            Success contact
          else
            Failure contact
          end
        end
      end
    end
  end
end
