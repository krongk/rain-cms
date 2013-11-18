class Admin::Page < ActiveRecord::Base
  belongs_to :user
  belongs_to :channel

  acts_as_taggable

  validates :channel, :title, :short_title, presence: true
  validates :short_title, format: { with: /\A[a-zA-Z0-9-]+\z/,
    message: "名称简写只能包括字母数字和横线" }

  def short_description(count)
    self.description.to_s.truncate(count)
  end
  def format_date
    self.updated_at.strftime("%Y-%M-%d")
  end
  
  #最近新闻
  #typo = ['article', 'image', 'product']
  #channel =[ channel.short_title, ]
  def self.recent(count = 10, options = {})
    options = {typo: 'all'}.merge(options)
    pages = Admin::Page.order("updated_at DESC").limit(count)
    pages = pages.select{|p| p.channel.typo == options[:typo]} unless options[:typo] == 'all'
    pages = pages.select{|p| p.channel.short_title == options[:channel]} unless options[:channel].nil?
    pages
  end

end
