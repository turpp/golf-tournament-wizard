class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :name
      t.integer :handicap
      t.belongs_to :user, null: false, foreign_key: true


      t.timestamps
    end
  end
end
