class AddOwnerToInventory < ActiveRecord::Migration
  def up
    add_belongs_to :inventories, :user
  end

  def down
    remove_belongs_to :inventories, :user
  end
end
