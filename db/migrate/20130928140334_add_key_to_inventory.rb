class AddKeyToInventory < ActiveRecord::Migration
  def up
    add_column :inventories, :key, :string
    add_index :inventories, :key, unique: true
  end

  def down
    remove_index :inventories, :key
    remove_column :inventories, :key
  end
end
