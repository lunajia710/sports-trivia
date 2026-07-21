class CreateOptions < ActiveRecord::Migration[8.1]
  def change
    create_table :options do |t|
      t.text :response
      t.boolean :is_solution
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
