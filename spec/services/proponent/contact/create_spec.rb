# frozen_string_literal: true

require 'rails_helper'
require 'ostruct'

RSpec.describe Services::Proponent::Contact::Create do
  let(:service) { described_class.new }

  let(:phone) { '5514991' }
  let(:category) { 'personal' }
  let(:proponent) { create :proponent }
  let(:proponent_id) { proponent.id }

  let(:attributes) do
    { phone:, category:, proponent_id: }
  end

  let(:result) { service.with_step_args(create: [attributes]).call(proponent_id) }

  context '#call' do
    context 'with success' do
      it { expect(result.success?).to be_truthy }
      it { expect(result.success.phone).to eq(phone) }
      it { expect(result.success.category).to eq(category) }
      it { expect { result }.to change(Contact, :count).by(1) }
    end

    context 'with validations' do
      context 'phone' do
        describe 'missing' do
          let(:phone) { '' }

          it { expect(result.failure?).to be_truthy }
          it { expect(result.failure.errors[:phone].first).to eq("can't be blank") }
        end
      end
    end
  end
end
