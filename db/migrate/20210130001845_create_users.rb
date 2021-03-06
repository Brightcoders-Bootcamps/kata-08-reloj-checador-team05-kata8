class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :position
      t.integer :enabled
      t.integer :private_number
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
