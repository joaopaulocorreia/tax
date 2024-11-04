require 'ostruct'

module Services
  module Proponent
    class Update < ApplicationService
      step :find_proponent
      step :update

      def find_proponent(id)
        proponent = ::Proponent.find_by(id:)

        if proponent
          Success proponent
        else
          Failure :record_not_found
        end
      end

      def update(proponent, attributes)
        if proponent.update(attributes)
          Success proponent
        else
          Failure proponent
        end
      end
    end
  end
end
