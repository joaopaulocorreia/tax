# frozen_string_literal: true

module Services
  module Proponent
    module Address
      class Update < ApplicationService
        step :find_proponent
        step :update

        def find_proponent(id)
          proponent = ::Proponent.find_by(id:)

          if proponent
            Success OpenStruct.new(proponent:)
          else
            Failure :record_not_found
          end
        end

        def update(ctx, attributes)
          address = ctx.proponent.address

          if address.update(attributes)
            Success address
          else
            Failure address
          end
        end
      end
    end
  end
end
