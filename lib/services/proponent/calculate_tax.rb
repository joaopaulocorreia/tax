require 'ostruct'

module Services
  module Proponent
    class CalculateTax < ApplicationService
      step :find_group
      step :schedule

      private

      def find_group(salary)
        return Failure :salary_cannot_be_negative if salary.negative?

        tax = TaxTable.where(":salary >= initial and :salary <= final", salary:).take
        tag = tax&.tag

        Success OpenStruct.new(tax:, salary:, tag:)
      end

      def schedule(ctx)
        case ctx.tag
        when 'group_one'
          Success [round_down(calculate_current_tax(ctx.salary, 0, ctx.tax.percentage), 2), ctx.tax]
        when 'group_two'
          previous_tax = calculate_previous_tax([:group_one])
          current_tax = calculate_current_tax(ctx.salary, ctx.tax.initial, ctx.tax.percentage)
          total = current_tax + previous_tax

          Success [round_down(total, 2), ctx.tax]
        when 'group_three'
          previous_tax = calculate_previous_tax([:group_one, :group_two])
          current_tax = calculate_current_tax(ctx.salary, ctx.tax.initial, ctx.tax.percentage)
          total = current_tax + previous_tax

          Success [round_down(total, 2), ctx.tax]
        when 'group_four'
          previous_tax = calculate_previous_tax([:group_one, :group_two, :group_three])
          current_tax = calculate_current_tax(ctx.salary, ctx.tax.initial, ctx.tax.percentage)
          total = current_tax + previous_tax

          Success [round_down(total, 2), ctx.tax]
        else
          total = calculate_previous_tax([:group_one, :group_two, :group_three, :group_four])
          tax = TaxTable.find_by_tag :group_four

          Success [round_down(total, 2), tax]
        end
      end

      def round_down(x, n = 2)
        ("%.#{n}f" % x.to_d.truncate(n)).to_f
      end

      def calculate_previous_tax(groups_tag)
        total = TaxTable
          .where(tag: groups_tag)
          .map(&:calculated_tax)
          .sum

        round_down(total, 2)
      end

      def calculate_current_tax(salary, initial, percentage)
        range_to_calculate = salary - initial
        calculated_tax = (range_to_calculate * percentage) / 100
        round_down(calculated_tax, 2)
      end
    end
  end
end
