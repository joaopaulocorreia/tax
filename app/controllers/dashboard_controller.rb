# frozen_string_literal: true

class DashboardController < ApplicationController
  def index
    @tags = TaxTable.joins(:proponents).group('tax_tables.tag').order(:tag).count
  end
end
