# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address, type: :model do
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

  let(:record) { described_class.create(attributes) }

  describe 'with success' do
    it { expect(record.valid?).to be_truthy }
    it { expect { record }.to change(Address, :count).by(1) }
    it { expect(record.address).to eq(address) }
    it { expect(record.number).to eq(number) }
    it { expect(record.neighborhood).to eq(neighborhood) }
    it { expect(record.city).to eq(city) }
    it { expect(record.state).to eq(state) }
    it { expect(record.postal_code).to eq(postal_code) }
    it { expect(record.proponent.id).to eq(proponent.id) }
  end

  describe 'with validations' do
    it { should validate_presence_of(:address) }

    context 'address' do
      describe 'missing' do
        let(:address) { '' }
        it { expect(record.errors[:address].first).to eq("can't be blank") }
      end
    end

    context 'number' do
      describe 'missing' do
        let(:number) { '' }
        it { expect(record.errors[:number].first).to eq("can't be blank") }
      end
    end

    context 'neighborhood' do
      describe 'missing' do
        let(:neighborhood) { '' }
        it { expect(record.errors[:neighborhood].first).to eq("can't be blank") }
      end
    end

    context 'city' do
      describe 'missing' do
        let(:city) { '' }
        it { expect(record.errors[:city].first).to eq("can't be blank") }
      end
    end

    context 'state' do
      describe 'missing' do
        let(:state) { '' }
        it { expect(record.errors[:state].first).to eq("can't be blank") }
      end
    end

    context 'postal_code' do
      describe 'missing' do
        let(:postal_code) { '' }
        it { expect(record.errors[:postal_code].first).to eq("can't be blank") }
      end
    end

    context 'proponent' do
      describe 'missing' do
        let(:proponent_id) { '' }
        it { expect(record.errors[:proponent].first).to eq('must exist') }
      end
    end
  end
end
