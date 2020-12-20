class CreateTournaments < ActiveRecord::Migration[6.0]
  def change
    create_table :tournaments do |t|
      t.string :name
      t.date :date
      t.integer :entry_fee
      t.integer :user_id
      t.integer :players_on_team
      t.integer :number_of_rounds
      t.integer :holes_per_round

      t.timestamps
    end
  end
end
