class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :full_name, null: false
      t.string :username
      t.string :password_digest, null: false
      t.string :email, null: false
      t.integer :status, null: false, default: 1
      t.integer :role, null: false, default: 1
      t.date :date_of_birth
      t.timestamps
    end
  end
end
