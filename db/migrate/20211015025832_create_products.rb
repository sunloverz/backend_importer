class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      enable_extension :citext
      t.string :price_list
      t.citext :brand, null: false
      t.citext :code, null: false
      t.integer :stock, default: 0, null: false
      t.decimal :cost, precision: 12, scale: 2, null: false
      t.string :name

      t.timestamps({default: -> { "CURRENT_TIMESTAMP" }})
    end
        
    add_index :products, [:brand, :code], unique: true
  end
end
