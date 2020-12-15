class CreateRounds < ActiveRecord::Migration[6.0]
  def change
    create_table :rounds do |t|
      t.belongs_to :tournament, null: false, foreign_key: true
      t.belongs_to :player, null: false, foreign_key: true
      t.integer :final_score

      t.timestamps
    end
  end
end
