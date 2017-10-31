class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string  :name, null: false
      t.integer :status, null: false, default: 1
      t.string  :category_constant
      t.integer :category_type

      t.timestamps
      t.index :name
      t.index :category_constant
    end
  end
end
