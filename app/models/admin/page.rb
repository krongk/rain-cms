class Admin::Page < ActiveRecord::Base
  belongs_to :user
  belongs_to :channel
  self.per_page = 24

  acts_as_taggable

  validates :channel, :title, presence: true
  validates :short_title, format: { with: /\A[a-zA-Z0-9-]+\z/,
    message: "名称简写只能包括字母数字和横线" }
  validates_uniqueness_of :short_title

  before_save :set_content_image, :set_thumb_image_path

  #cache
  after_save :expire_cache
  def expire_cache
    logger.info "page #{self.id} saved!"
    cache_paths = [] 
    cache_paths << File.join(Rails.root, 'public', 'page_cache', 'index.html')
    cache_paths << File.join(Rails.root, 'public', 'page_cache', self.channel.short_title, self.id.to_s + '.html')
    cache_paths << File.join(Rails.root, 'public', 'page_cache', self.channel.id.to_s, self.id.to_s + '.html')
    cache_paths.each do |path|
      if File.exist?(path)
        FileUtils.rm_rf path
        logger.info "cache expire page: #{path}, #{!File.exist?(path)}"
      end
    end
  end

  def short_description(count = 50)
    self.description.to_s.truncate(count)
  end
  
  def format_date
    self.updated_at.strftime("%Y-%m-%d") unless self.updated_at.nil?
  end

  def thumb_image_path
    self.image_path.sub(/content/, 'thumb')
  end

  # "H|C|F" => ['H', 'C', 'F']
  # 用于在_form.html.erb中初始化值
  def arr_properties
    properties.to_s.split('|')
  end

  #最近新闻
  #params: 
  # => typo = ['article', 'image', 'product']
  # => channel =[ channel.short_title, ]
  # => properties =[recommend, top, hot]
  #eg: Admin::Page.recent(12, :typo => 'product',  :rand => true)
  #    Admin::Page.recent(10, :channel => 'product-bed', :properties => '1')
  def self.recent(count = 10, options = {})
    queries     = []
    conditions  = []
    if options[:channel].present?
      queries     << 'admin_channels.short_title = ?'
      conditions  << options[:channel]
    end
    if options[:typo].present?
      queries     << 'admin_channels.typo = ?'
      conditions  << options[:typo]
    end
    if options[:properties].present?
      queries     << 'admin_pages.properties regexp ?'
      conditions  << options[:properties]
    end
    conditions.unshift(queries.join(' AND '))
    return Admin::Page.joins(:channel).where(conditions).order("updated_at DESC").limit(count)
  end

  #搜索
  def self.search(search)
    if search
      where('title LIKE ?', "%#{search}%")
    else
      all
    end
  end

  private

  def set_thumb_image_path
    if image_path =~ /\/(content|original)\./
      image_path.sub!(/\/(content|original)\./, '/thumb.')
    end
  end

  def set_content_image
    doc = Nokogiri::HTML(content)
    begin
      doc.search("img").each do |img|
        img.remove_attribute("style")
        if img.attributes["class"].nil?
          img.set_attribute("class", "img-responsive")
        elsif (val = img.attribute("class").value) !~ /img-responsive/
          img.set_attribute("class", "#{val} img-responsive")
        end
      end
    rescue => ex
      puts ex.message
    end
    self.content = doc.at("body").inner_html
  end

end
