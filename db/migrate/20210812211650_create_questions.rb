class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.references :my_pool, null: false, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
