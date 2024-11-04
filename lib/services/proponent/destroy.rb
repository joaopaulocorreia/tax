module Services
  module Proponent
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

      def destroy(proponent)
        proponent.destroy

        if proponent.destroyed?
          Success proponent
        else
          Failure :record_not_destroyed
        end
      end
    end
  end
end
