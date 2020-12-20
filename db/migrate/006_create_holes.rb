class CreateHoles < ActiveRecord::Migration[6.0]
  def change
    create_table :holes do |t|
      t.integer :score
      t.belongs_to :round, null: false, foreign_key: true
      t.timestamps
    end
  end
end
