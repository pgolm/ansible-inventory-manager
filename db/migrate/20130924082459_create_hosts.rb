class CreateHosts < ActiveRecord::Migration
  def change
    create_table :hosts do |t|
      t.string :alias
      t.text :description
      t.text :variables, default: '{}'

      t.belongs_to :inventory

      t.timestamps
    end

    add_index :hosts, [:alias, :inventory_id]
  end
end
