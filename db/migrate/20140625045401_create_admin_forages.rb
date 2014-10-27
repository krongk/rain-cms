class CreateAdminForages < ActiveRecord::Migration
  def change
    create_table :admin_forages do |t|
      t.string :title
      t.text :content
      t.string :tag
      t.string :author
      t.string :original_url
      t.string :image_url
      t.timestamps
    end
  end
end
