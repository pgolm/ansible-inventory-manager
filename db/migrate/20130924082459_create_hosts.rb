class CreateHosts < ActiveRecord::Migration
  def change
    create_table :hosts do |t|
      t.string :alias, null: false
      t.text :description
      t.text :variables, default: '{}'

      t.belongs_to :inventory, null: false

      t.timestamps
    end

    add_index :hosts, [:alias, :inventory_id],  unique: true
  end
end
