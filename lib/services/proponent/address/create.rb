module Services
  module Proponent
    module Address
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
          address = ctx.proponent.create_address attributes

          if address.save
            Success address
          else
            Failure address
          end
        end
      end
    end
  end
end
