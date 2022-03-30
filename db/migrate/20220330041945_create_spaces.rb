class CreateSpaces < ActiveRecord::Migration[7.0]
  def change
    create_table :spaces do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.decimal :price, null: false
      t.string :image, null: false
      t.boolean :removed, null: false, default: false
      t.references :users, null: false, foreign_key: true

      t.timestamps
    end
  end
end
