class AddCart < ActiveRecord::Migration[6.0]
  def change
    create_table :carts do |t|
      t.text :identifier

      t.timestamps
    end

    add_index :carts, :identifier, unique: true
  end
end
