class UpdateTaxJob < ApplicationJob
  def perform(proponent_id, salary)
    proponent = Proponent.find(proponent_id)

    service = Services::Proponent::CalculateTax.new
    service.call(salary.to_f) do |m|
      m.success do |result|
        tax, tax_table = result

        unless proponent.update(salary:, tax:, tax_table_id: tax_table.id)
          raise StandardError.new(proponent.errors)
        end
      end

      m.failure do |error|
        raise StandardError.new(error)
      end
    end
  end
end
