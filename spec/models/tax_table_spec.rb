require 'rails_helper'

RSpec.describe TaxTable, type: :model do
  let(:initial) { 2089.61 }
  let(:final) { 3134.4 }
  let(:percentage) { 12 }
  let(:tag) { :group_three }
  let(:calculated_tax) { 125.34 }

  let(:attributes) do
    { initial:, final:, percentage:, tag:, calculated_tax: }
  end

  let(:record) { described_class.create(attributes) }

  describe 'with success' do
    it { expect(record.valid?).to be_truthy }
    it { expect { record }.to change(TaxTable, :count).by(1) }
    it { expect(record.initial).to eq(initial) }
    it { expect(record.final).to eq(final) }
    it { expect(record.percentage).to eq(percentage) }
    it { expect(record.tag.to_sym).to eq(tag) }
    it { expect(record.calculated_tax).to eq(calculated_tax) }
  end

  describe 'with validations' do
    it { should validate_presence_of(:initial) }
    it { should validate_presence_of(:final) }
    it { should validate_presence_of(:percentage) }
    it { should validate_presence_of(:tag) }
    it { should validate_presence_of(:calculated_tax) }

    context 'initial' do
      describe 'missing' do
        let(:initial) { '' }
        it { expect(record.errors[:initial].first).to eq("can't be blank") }
      end
    end

    context 'final' do
      describe 'missing' do
        let(:final) { '' }
        it { expect(record.errors[:final].first).to eq("can't be blank") }
      end
    end

    context 'percentage' do
      describe 'missing' do
        let(:percentage) { '' }
        it { expect(record.errors[:percentage].first).to eq("can't be blank") }
      end
    end

    context 'tag' do
      describe 'missing' do
        let(:tag) { '' }
        it { expect(record.errors[:tag].first).to eq("can't be blank") }
      end
    end

    context 'calculated_tax' do
      describe 'missing' do
        let(:calculated_tax) { '' }
        it { expect(record.errors[:calculated_tax].first).to eq("can't be blank") }
      end
    end
  end
end
