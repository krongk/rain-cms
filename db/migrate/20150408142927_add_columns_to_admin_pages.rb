class AddColumnsToAdminPages < ActiveRecord::Migration
  def change
    add_column :admin_pages, :price, :decimal, precision: 8, scale: 2
    add_column :admin_pages, :discount, :decimal #10为不打折， 9为打9折
    add_column :admin_pages, :unit, :string #件／个／条
    add_column :admin_pages, :amount, :integer #库存数量

  end
end
