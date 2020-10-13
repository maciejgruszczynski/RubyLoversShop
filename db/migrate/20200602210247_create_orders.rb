class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.monetize :final_price_net
      t.string :shippment_method
      t.timestamp :confirmed_at
      
      t.timestamps
    end
  end
end
