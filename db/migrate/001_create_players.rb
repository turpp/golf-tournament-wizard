class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :name
      t.integer :handicap
      t.integer :user_id
      t.boolean :mulligan
      t.boolean :paid

      t.timestamps
    end
  end
end
