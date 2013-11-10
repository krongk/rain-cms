class CreateAdminChannels < ActiveRecord::Migration
  def change
    create_table :admin_channels do |t|
      t.references :user, index: true
      t.string :cate_type
      t.string :title
      t.string :properties
      t.string :default_index
      t.string :tmp_index
      t.string :tmp_list
      t.string :tmp_detial
      t.string :keywords
      t.string :description
      t.text :content

      t.timestamps
    end
  end
end
