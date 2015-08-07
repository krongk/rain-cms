class AddExternalUrlToAdminPage < ActiveRecord::Migration
  def change
    add_column :admin_pages, :external_url, :string #外部链接
  end
end
