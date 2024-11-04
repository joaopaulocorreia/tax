# frozen_string_literal: true

require 'ostruct'

module Services
  module Proponent
    class Create < ApplicationService
      step :create

      def create(attributes)
        proponent = ::Proponent.new(attributes)

        if proponent.save
          Success proponent
        else
          Failure proponent
        end
      end
    end
  end
end
