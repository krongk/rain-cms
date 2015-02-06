class AddCateIdToTag < ActiveRecord::Migration
  def change
    add_column :tags, :cate_id, :integer
    add_index :tags, :cate_id
  end

end
