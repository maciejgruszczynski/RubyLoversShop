class CreateDeliveryMethods < ActiveRecord::Migration[6.0]
  def change
    create_table :delivery_methods do |t|
      t.string :name, null: false, unique: true

      t.timestamps
    end
  end
end
