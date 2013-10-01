class CreateGroupHosts < ActiveRecord::Migration
  def change
    create_table :group_hosts do |t|
      t.belongs_to :host, null: false
      t.belongs_to :group, null: false

      t.timestamps
    end
  end
end
