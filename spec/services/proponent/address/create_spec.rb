require 'rails_helper'
require 'ostruct'

RSpec.describe Services::Proponent::Address::Create do
  let(:service) { described_class.new }

  let(:address) { 'street xpto' }
  let(:number) { '123' }
  let(:neighborhood) { 'community xpto' }
  let(:city) { 'xpto city' }
  let(:state) { 'xpto state' }
  let(:postal_code) { 'zyzz_brah' }
  let(:proponent) { create :proponent }
  let(:proponent_id) { proponent.id }

  let(:attributes) do
    { address:, number:, neighborhood:, city:, state:, postal_code:, proponent_id: }
  end

  let(:result) { service.with_step_args(create: [attributes]).call(proponent_id) }

  context '#call' do
    context 'with success' do
      it { expect(result.success?).to be_truthy }
      it { expect(result.success.address).to eq(address) }
      it { expect(result.success.number).to eq(number) }
      it { expect { result }.to change(Address, :count).by(1) }
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
