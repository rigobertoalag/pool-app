class CreateTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :tokens do |t|
      t.datetime :expires_at
      t.references :user, null: false, foreign_key: true
      t.string :token

      t.timestamps
    end
  end
end
