#xj:
# 1. rake sitemap:install to create config/sitemap.rb
# 1.1 edit config/sitemap.rb
# 2. run test: rake sitemap:refresh:no_ping
# 2.1. on production run: rake sitemap:refresh
# 3. add below to robotes.txt 
# => Sitemap: http://www.example.com/sitemap.xml.gz
# 4. edit config/schedule.rb
  # every 5.days do 
  #   rake "rake sitemap:refresh"
  # end
# 4.1 run: bundle exec whenever

# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://#{ENV["HOST_NAME"]}"

#Add aditional ping search engin
  # SitemapGenerator::Sitemap.search_engines =>  {:google=>"http://www.google.com/webmasters/tools/ping?sitemap=%s",
  #  :bing=>"http://www.bing.com/webmaster/ping.aspx?siteMap=%s"}
  SitemapGenerator::Sitemap.search_engines[:baidu] = "http://ping.baidu.com/ping/RPC2"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  Admin::Channel.tag_counts_on(:tags).each do |tag|
    add tag_path(tag), :priority => 0.6, :changefreq => 'weekly'
  end
  Admin::Page.tag_counts_on(:tags).each do |tag|
    add tag_path(tag), :priority => 0.5, :changefreq => 'weekly'
  end

  Admin::Channel.find_each do |channel|
    add "/#{channel.short_title}", :priority => 0.8, :changefreq => 'daily'
  end

  Admin::Page.find_each do |page|
    add "/#{page.channel.short_title}/#{page.short_title}", :priority => 0.7, :changefreq => 'daily'
  end

end
