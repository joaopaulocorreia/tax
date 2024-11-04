require 'rails_helper'

RSpec.describe Contact, type: :model do
  let(:phone) { '5514991' }
  let(:category) { 'personal' }
  let(:proponent) { create :proponent }
  let(:proponent_id) { proponent.id }

  let(:old_contact) { create :contact }

  let(:attributes) do
    { phone:, category:, proponent_id: }
  end

  let(:record) { described_class.create(attributes) }

  describe 'with success' do
    it { expect(record.valid?).to be_truthy }
    it { expect { record }.to change(Contact, :count).by(1) }
    it { expect(record.phone).to eq(phone) }
    it { expect(record.category).to eq(category) }
    it { expect(record.proponent.id).to eq(proponent_id) }
  end

  describe 'with validations' do
    it { should validate_presence_of(:phone) }

    it { should belong_to(:proponent) }

    context 'phone' do
      describe 'missing' do
        let(:phone) { '' }
        it { expect(record.errors[:phone].first).to eq("can't be blank") }
      end

      describe 'exists' do
        let(:phone) { old_contact.phone }
        it { expect(record.errors[:phone].first).to eq("has already been taken") }
      end
    end

    context 'category' do
      describe 'missing' do
        let(:category) { '' }
        it { expect(record.errors[:category].first).to eq("is not included in the list") }
      end
    end

    context 'proponent' do
      describe 'missing' do
        let(:proponent_id) { '' }
        it { expect(record.errors[:proponent].first).to eq("must exist") }
      end
    end
  end
end
