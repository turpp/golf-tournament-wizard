class CreatePlayersTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :players_teams do |t|
      t.belongs_to :player, null: false, foreign_key: true
      t.belongs_to :team, null: false, foreign_key: true
      t.boolean :mulligan, default: false
      t.boolean :paid, default: false

      t.timestamps
    end
  end
end
