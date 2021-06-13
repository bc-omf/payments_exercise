require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  describe '#index' do
    let(:loan) { Loan.create!(funded_amount: 100.0) }

    it 'responds with a 200' do
      get :index, params: { loan_id: loan.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#show' do
    let(:loan) { Loan.create!(funded_amount: 100.0) }
    let(:payment) { loan.payments.create!(payment_amount: 25.0) }

    it 'responds with a 200' do
      get :show, params: { loan_id: loan.id, id: payment.id }
      expect(response).to have_http_status(:ok)
    end

    context 'if the loan is not found' do
      it 'responds with a 404' do
        get :show, params: { loan_id: loan.id, id: 10_000 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe '#create' do
    let(:loan) { Loan.create!(funded_amount: 100.0) }
    let(:payment) { loan.payments.create!(payment_amount: 25.0) }

    it 'responds with a 201 when valid payment is submitted' do
      post :create, params: { loan_id: loan.id, payment_amount: 25.0 }
      expect(response).to have_http_status(:created)
    end

    it 'expect outstanding balance to reduce by payment amount' do
      post :create, params: { loan_id: loan.id, payment_amount: 25.0 }
      expect(loan.outstanding_balance).to eq(75.00)
    end

    it 'returns 422 when payment is more than outstanding balance' do
      post :create, params: { loan_id: loan.id, payment_amount: 101.0 }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns 422 when payment amount empty' do
      post :create, params: { loan_id: loan.id }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
