class Payment < ActiveRecord::Base
  belongs_to :loan
  validates_presence_of :payment_amount
  validate :payment_cannot_be_greater_than_outstanding_balance

  def payment_cannot_be_greater_than_outstanding_balance
    return unless
        loan.outstanding_balance.to_f < payment_amount

    errors.add(:payment, "can't be greater than outstanding balance")
  end
end
