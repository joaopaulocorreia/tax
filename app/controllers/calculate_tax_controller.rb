class CalculateTaxController < ApplicationController
  def calculate
    service = Services::Proponent::CalculateTax.new
    service.call(params[:salary].to_f) do |m|
      m.success do |result|
        calculated_tax, tax_table = result

        render json: { calculated_tax:, tax_table_id: tax_table.id }
      end

      m.failure
    end
  end
end
