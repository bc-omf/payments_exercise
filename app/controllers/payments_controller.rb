class PaymentsController < ApplicationController
  before_action :set_loan, only: %i[index show create]

  def index
    render json: @loan.payments.all
  end

  def show
    render json: @loan.payments.find(params[:id])
  end
  
  def create
    render status: :created, json: @loan.payments.create!(payment_amount: params[:payment_amount])
  end
  
  private
  
  def set_loan
    @loan = Loan.find(params[:loan_id])
  end
end
