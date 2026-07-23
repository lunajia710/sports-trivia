class CreateRounds < ActiveRecord::Migration[8.1]
  def change
    create_table :rounds do |t|
      t.integer :score, null: false, default: 0
      t.references :deck, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
