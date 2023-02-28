class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :quantity
      t.integer :price_in_cents

      t.timestamps
    end
  end
end
