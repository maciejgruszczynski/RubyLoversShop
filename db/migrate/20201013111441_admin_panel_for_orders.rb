class AdminPanelForOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :identifier, :string
    rename_column :orders, :shippment_method, :delivery_method
    add_column :orders, :customer_email, :string
    add_column :orders, :state, :string
    remove_column :orders, :confirmed_at, :timestamp
  end
end
