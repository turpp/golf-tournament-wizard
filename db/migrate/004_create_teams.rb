class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.integer :final_score
      t.string :divison

      t.belongs_to :tournament, null: false, foreign_key: true

      t.timestamps
      
    end
  end
end
