class AddPaymentTokenToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :payment_token, :string
    add_column :orders, :payment_errors, :string, default: nil
  end
end
