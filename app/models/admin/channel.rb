class Admin::Channel < ActiveRecord::Base
  belongs_to :user
  has_many :pages
  has_many :children, class_name: "Admin::Channel",
                          foreign_key: "parent_id"
  belongs_to :parent, class_name: "Admin::Channel"

  TYPOS = %w[article image product]
  
  acts_as_taggable

  validates :typo, :title, :short_title, :tmp_index, :tmp_detail, presence: true
  validates :short_title, format: { with: /\A[a-zA-Z0-9-]+\z/,
    message: "名称简写只能包括字母数字和横线" }

end
