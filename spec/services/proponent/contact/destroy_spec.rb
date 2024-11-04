require 'rails_helper'

RSpec.describe Services::Proponent::Contact::Destroy do
  let(:service) { described_class.new }

  let!(:contact) { create :contact }
  let(:id) { contact.id }
  let(:proponent_id) { contact.proponent_id }

  let(:result) { service.with_step_args(destroy: [id]).call(proponent_id) }

  context '#call' do
    context 'with success' do
      it { expect(result.success?).to be_truthy }
      it { expect { result }.to change(Contact, :count).by(-1) }
    end

    context 'with validations' do
      context 'error deleting' do
        before do
          allow_any_instance_of(Contact).to receive(:destroyed?).and_return(false)
        end

        it { expect(result.failure?).to be_truthy }
        it { expect(result.failure).to eq(:record_not_destroyed) }
      end

      context 'proponent not found' do
        let(:proponent_id) { nil }

        it { expect(result.failure?).to be_truthy }
        it { expect(result.failure).to be(:record_not_found) }
      end

      context 'contact not found' do
        let(:id) { nil }

        it { expect(result.failure?).to be_truthy }
        it { expect(result.failure).to be(:record_not_found) }
      end
    end
  end
end
