class CreateAdminProperties < ActiveRecord::Migration
  def change
    create_table :admin_properties do |t|
      t.string :name, :null => false
    end
    add_index :admin_properties, :name, :unique => true

    execute "insert into admin_properties (name) values ('头条')"
    execute "insert into admin_properties (name) values ('推荐')"
    execute "insert into admin_properties (name) values ('幻灯')"
    execute "insert into admin_properties (name) values ('底部')"
    execute "insert into admin_properties (name) values ('滚动')"
    execute "insert into admin_properties (name) values ('加粗')"
    execute "insert into admin_properties (name) values ('图片')"
    execute "insert into admin_properties (name) values ('跳转')"
  end
end

