class AddImagePathToAdminChannel < ActiveRecord::Migration
  def change
    add_column :admin_channels, :image_path, :string
  end
end
