class CreateQuestions < ActiveRecord::Migration[8.1]
  def change
    create_table :questions do |t|
      t.text :question
      t.references :deck, null: false, foreign_key: true

      t.timestamps
    end
  end
end
