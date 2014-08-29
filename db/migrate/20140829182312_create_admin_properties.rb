class CreateAdminProperties < ActiveRecord::Migration
  def change
    create_table :admin_properties do |t|
      t.string :name, :null => false
    end
    add_index :admin_properties, :name, :unique => true
  end
end

