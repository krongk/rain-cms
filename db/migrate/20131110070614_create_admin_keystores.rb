class CreateAdminKeystores < ActiveRecord::Migration
  def change
    create_table :admin_keystores do |t|
      t.string :name
      t.string :value
      t.string :description
      t.timestamps
    end
    add_index :admin_keystores, :name, :unique => true
  end
end
