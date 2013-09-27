class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
