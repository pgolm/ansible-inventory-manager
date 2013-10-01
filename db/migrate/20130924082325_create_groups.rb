class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.text :description
      t.text :variables, default: '{}'

      t.belongs_to :group
      t.belongs_to :inventory, null: false

      t.timestamps
    end

    add_index :groups, [:name, :group_id, :inventory_id], unique: true
  end
end
