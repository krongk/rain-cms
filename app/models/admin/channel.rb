class Admin::Channel < ActiveRecord::Base
  belongs_to :user
  has_many :pages, dependent: :destroy
  has_many :children, class_name: "Admin::Channel",
                          foreign_key: "parent_id",
                          dependent: :destroy
  belongs_to :parent, class_name: "Admin::Channel"

  TYPOS = %w[article image product]
  
  acts_as_taggable

  validates :typo, :title, :short_title, :tmp_index, :tmp_detail, presence: true
  validates :short_title, format: { with: /\A[a-zA-Z0-9-]+\z/,
    message: "名称简写只能包括字母数字和横线" }

  #cache
  after_save :expire_cache
  def expire_cache
    cache_index_path = File.join(Rails.root, 'public', 'index.html')
    cache_cate_path = File.join(Rails.root, 'public', self.short_title + '.html')
    FileUtils.rm_rf cache_index_path if File.exist?(cache_index_path)
    FileUtils.rm_rf cache_cate_path if File.exist?(cache_cate_path)
  end

end
