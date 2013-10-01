class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :email, null: false
      t.string :api_key
      t.boolean :is_admin, default: false, null: false

      t.timestamps
    end

    add_index :users, :api_key
  end
end
