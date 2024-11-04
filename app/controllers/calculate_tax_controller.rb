class CalculateTaxController < ApplicationController
  def calculate
    service = Services::Proponent::CalculateTax.new
    service.call(params[:salary].to_f) do |m|
      m.success do |tax|
        render json: tax
      end

      m.failure
    end
  end
end
