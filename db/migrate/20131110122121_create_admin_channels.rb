class CreateAdminChannels < ActiveRecord::Migration
  def change
    create_table :admin_channels do |t|
      t.references :user, index: true
      t.integer :parent_id
      t.string :typo
      t.string :title
      t.string :short_title
      t.string :properties
      t.string :default_url
      t.string :tmp_index
      t.string :tmp_list
      t.string :tmp_detial
      t.string :keywords
      t.string :description
      t.text :content

      t.timestamps
    end
    add_index :admin_channels, :parent_id, unique: true
    add_index :admin_channels, :title, unique: true
    add_index :admin_channels, :short_title, unique: true
  end
end
