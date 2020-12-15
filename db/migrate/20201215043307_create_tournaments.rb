class CreateTournaments < ActiveRecord::Migration[6.0]
  def change
    create_table :tournaments do |t|
      t.string :name
      t.date :date
      t.integer :entry_fee
      t.string :rules
      t.belongs_to :user, null: false, foreign_key: true


      t.timestamps
    end
  end
end
