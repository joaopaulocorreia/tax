require 'rails_helper'
require 'ostruct'

RSpec.describe Services::Proponent::Address::Update do
  let(:service) { described_class.new }

  let(:address) { 'street xpto' }
  let(:number) { '123' }

  let!(:old_address) { create :address }

  let(:attributes) do
    { address:, number: }
  end

  let(:result) { service.with_step_args(update: [attributes]).call(old_address.proponent_id) }

  context '#call' do
    context 'with success' do
      it { expect(result.success?).to be_truthy }
      it { expect(result.success.address).to eq(address) }
      it { expect(result.success.number).to eq(number) }
    end

    context 'with validations' do
      context 'name' do
        describe 'missing' do
          let(:address) { '' }

          it { expect(result.failure?).to be_truthy }
          it { expect(result.failure.errors[:address].first).to eq("can't be blank") }
        end
      end
    end
  end
end
