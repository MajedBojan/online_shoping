class CreateSubCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :sub_categories do |t|
      t.belongs_to :category, foreign_key: { on_delete: :cascade }, null: false
      t.string :name
      t.integer :status, default: 1, null: false
      t.timestamps
      t.index :name
    end
  end
end
