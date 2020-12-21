class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :address
      t.string :phone_number
      t.string :password_digest
      t.string :username
      t.string :uid
      t.string :email
      t.string :image

      t.timestamps
    end
  end
end
