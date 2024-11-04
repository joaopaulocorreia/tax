require 'rails_helper'

RSpec.describe Services::Proponent::Update do
  let(:service) { described_class.new }

  let(:name) { 'name xpto' }
  let(:cpf) { '12334567891' }

  let!(:proponent) { create :proponent }
  let(:id) { proponent.id }

  let(:params) { { name:, cpf: } }
  let(:result) { service.with_step_args(update: [params]).call(id) }

  context '#call' do
    context 'with success' do
      it { expect(result.success?).to be_truthy }
      it { expect(result.success.name).to eq(name) }
    end

    context 'with validations' do
      context 'not found' do
        let(:id) { '' }

        it { expect(result.failure?).to be_truthy }
        it { expect(result.failure).to eq(:record_not_found) }
      end

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
