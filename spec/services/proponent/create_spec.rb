# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Proponent::Create do
  let(:service) { described_class.new }

  let(:name) { 'name xpto' }
  let(:cpf) { '12334567891' }
  let(:birthday) { Time.zone.today }
  let(:salary) { 1000 }
  let(:tax) { 50 }
  let(:tax_table) { create :tax_table }
  let(:tax_table_id) { tax_table.id }

  let(:attributes) do
    { name:, cpf:, birthday:, salary:, tax:, tax_table_id: }
  end

  let(:result) { subject.call(attributes) }

  context '#call' do
    context 'with success' do
      it { expect(result.success?).to be_truthy }
      it { expect(result.success.name).to eq(name) }
      it { expect(result.success.cpf).to eq(cpf) }
      it { expect { result }.to change(Proponent, :count).by(1) }
    end

    context 'with validations' do
      context 'name' do
        describe 'missing' do
          let(:name) { '' }

          it { expect(result.failure?).to be_truthy }
          it { expect(result.failure.errors[:name].first).to eq("can't be blank") }
        end
      end
    end
  end
end
