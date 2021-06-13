class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.belongs_to :loan, foreign_key: true, null: false
      t.decimal :payment_amount, precision: 8, scale: 2, null: false

      t.timestamps
    end
  end
end
