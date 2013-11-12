class Admin::Channel < ActiveRecord::Base
  belongs_to :user
  has_many :pages
  has_many :children, class_name: "Admin::Channel",
                          foreign_key: "parent_id"
 
  belongs_to :parent, class_name: "Admin::Channel"
end
