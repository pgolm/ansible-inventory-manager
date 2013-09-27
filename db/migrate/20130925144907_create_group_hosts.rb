class CreateGroupHosts < ActiveRecord::Migration
  def change
    create_table :group_hosts do |t|
      t.belongs_to :host
      t.belongs_to :group

      t.timestamps
    end
  end
end
