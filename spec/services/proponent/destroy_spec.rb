require 'rails_helper'

RSpec.describe Services::Proponent::Destroy do
  let(:service) { described_class.new }

  let!(:proponent) { create :proponent }
  let(:id) { proponent.id }
  let(:result) { service.call(id) }

  context '#call' do
    context 'with success' do
      it { expect(result.success?).to be_truthy }
      it { expect { result }.to change(Proponent, :count).by(-1) }
    end

    context 'with validations' do
      context 'error deleting' do
        before do
          allow_any_instance_of(Proponent).to receive(:destroyed?).and_return(false)
        end

        it { expect(result.failure?).to be_truthy }
        it { expect(result.failure).to eq(:record_not_destroyed) }
      end

      context 'not found' do
        let(:id) { nil }

        it { expect(result.failure?).to be_truthy }
        it { expect(result.failure).to be(:record_not_found) }
      end
    end
  end
end
