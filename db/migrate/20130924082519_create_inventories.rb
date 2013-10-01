class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.string :name, null: false
      t.text :description
      t.string :key, null: false

      t.belongs_to :user, null: false
      
      t.timestamps
    end

    add_index :inventories, [:name, :user_id], unique: true
  end
end
