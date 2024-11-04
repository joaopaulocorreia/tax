require 'rails_helper'

RSpec.describe Proponent, type: :model do
  let(:name) { 'name xpto' }
  let(:cpf) { '12334567891' }
  let(:birthday) { Date.today }
  let(:salary) { 1000 }
  let(:tax) { 50 }
  let(:tax_table) { create :tax_table }
  let(:tax_table_id) { tax_table.id }

  let(:attributes) do
    { name:, cpf:, birthday:, salary:, tax:, tax_table_id: }
  end

  let(:record) { described_class.create(attributes) }

  describe 'with success' do
    it { expect(record.valid?).to be_truthy }
    it { expect { record }.to change(Proponent, :count).by(1) }
    it { expect(record.name).to eq(name) }
    it { expect(record.cpf).to eq(cpf) }
    it { expect(record.birthday).to eq(birthday) }
    it { expect(record.salary).to eq(salary) }
    it { expect(record.tax).to eq(tax) }
    it { expect(record.tax_table.id).to eq(tax_table.id) }
  end

  describe 'with validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:cpf) }
    it { should validate_presence_of(:birthday) }
    it { should validate_presence_of(:salary) }

    it { should belong_to(:tax_table) }
    it { should have_one(:address) }
    it { should have_many(:contacts) }

    context 'name' do
      describe 'missing' do
        let(:name) { '' }
        it { expect(record.errors[:name].first).to eq("can't be blank") }
      end
    end

    context 'cpf' do
      describe 'missing' do
        let(:cpf) { '' }
        it { expect(record.errors[:cpf].first).to eq("can't be blank") }
      end

      describe 'missing' do
        let(:cpf) { '1234' }
        it { expect(record.errors[:cpf].first).to eq("is the wrong length (should be 11 characters)") }
      end
    end

    context 'birthday' do
      describe 'missing' do
        let(:birthday) { '' }
        it { expect(record.errors[:birthday].first).to eq("can't be blank") }
      end
    end

    context 'salary' do
      describe 'missing' do
        let(:salary) { '' }
        it { expect(record.errors[:salary].first).to eq("can't be blank") }
      end

      describe 'string' do
        let(:salary) { 'xpto' }
        it { expect(record.errors[:salary].first).to eq("is not a number") }
      end
    end

    context 'tax' do
      describe 'missing' do
        let(:tax) { '' }
        it { expect(record.errors[:tax].first).to eq("fill salary to calculate tax") }
      end

      describe 'string' do
        let(:tax) { 'xpto' }
        it { expect(record.errors[:tax].first).to eq("is not a number") }
      end
    end

    context 'tax_table' do
      describe 'missing' do
        let(:tax_table_id) { '' }
        it { expect(record.errors[:tax_table].first).to eq("must exist") }
      end
    end
  end
end
