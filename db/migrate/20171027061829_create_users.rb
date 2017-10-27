class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :full_name, null: false
      t.string :username
      t.string :email, null: false
      t.boolean :status, null: false, default: true
      t.integer :role, null: false, default: 1
      t.date :date_of_birth
      t.timestamps
    end
  end
end
