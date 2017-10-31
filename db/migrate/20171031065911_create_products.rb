class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.belongs_to :sub_category, foreign_key: { on_delete: :cascade }, null: false
      t.belongs_to :user, foreign_key: { on_delete: :cascade }, null: false
      t.string :name
      t.string :description
      t.string :band_colour
      t.string :band_material
      t.string :brand
      t.string :dial_colour
      t.string :display_type
      t.decimal :price, default: '0.0', null: false
      t.decimal :discount_price, default: '0.0', null: false
      t.integer :status, default: 1, null: false
      t.timestamps
      t.index :name
      t.index :price
    end
  end
end
