class Loan < ActiveRecord::Base
  has_many :payments
  attribute :outstanding_balance

  def outstanding_balance
    funded_amount - payments.sum(:payment_amount)
  end
end
