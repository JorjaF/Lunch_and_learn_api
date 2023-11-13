class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.string :email, unique: true
      t.string :api_key

      t.timestamps
    end
  end
end
