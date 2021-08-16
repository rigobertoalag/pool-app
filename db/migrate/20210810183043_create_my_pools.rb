class CreateMyPools < ActiveRecord::Migration[6.1]
  def change
    create_table :my_pools do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :expires_at
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
