class CreateTournaments < ActiveRecord::Migration[6.0]
  def change
    create_table :tournaments do |t|
      t.string :name
      t.date :date
      t.integer :entry_fee
      t.integer :user_id
      t.boolean :team_tournament

      t.timestamps
    end
  end
end
