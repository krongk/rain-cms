#encoding: utf-8
require 'rubygems'
require 'optparse'
require 'active_record'

class LocalTableBase < ActiveRecord::Base
  self.abstract_class = true
  # self.pluralize_table_names = false
end

LocalTableBase.establish_connection(
 :adapter => 'mysql2',
 :reconnect => true,
 :wait_timeout => 600,
 :pool => 50,
 :username => 'root',
 :password => 'kenrome001',
 :host => '127.0.0.1',
 :port => 3307,
 :database => 'rxy' 
)

class AdminChannel < LocalTableBase
end
# define main class
class DataExtractor

  def initialize(args)
    print_and_exit($USAGE) if args.length == 0
    
    opt = OptionParser.new
    opt.on('-h', '--help') { print_and_exit($USAGE)}
    opt.on('-e', '--theme theme') { |theme| @theme = theme.downcase }
    opt.parse!(args)
    print_and_exit('please provide theme name with -e <theme>') if @theme.nil?
  end
  
  def run
    #在这里填写没个栏目内容, 先创建父级栏目，再添加子级
    puts "truncate tables"
    AdminChannel.connection.execute("truncate table admin_channels")
    AdminChannel.connection.execute("truncate table admin_pages")
    AdminChannel.connection.execute("truncate table taggings")
    AdminChannel.connection.execute("truncate table tags")

    puts "create new channel"
    #1
    AdminChannel.create!(
      :parent_id    => nil,
      :typo         => 'article',
      :title        => '首页',
      :short_title  => 'index',
      :properties   => 1,
      :default_url  => nil,
      :tmp_index    => 'temp_index.html',
      :tmp_detail   => nil,
      :keywords     => '瑞信云',
      :description  => ''
    )
    #2
    AdminChannel.create!(
      :parent_id    => nil,
      :typo         => 'article',
      :title        => '关于瑞信云',
      :short_title  => 'about',
      :properties   => 1,
      :tmp_index    => 'temp_default.html',
      :tmp_detail   => 'temp_default.html',
      :default_url  => nil,
      :keywords     => '瑞信云',
      :description  => '瑞信云'
    )
    #3
    AdminChannel.create!(
      :parent_id    => nil,
      :typo         => 'article',
      :title        => '产品及服务',
      :short_title  => 'service',
      :properties   => 1,
      :tmp_index    => 'temp_default.html',
      :tmp_detail   => 'temp_default.html',
      :default_url  => nil,
      :keywords     => '瑞信云产品及服务',
      :description  => '瑞信云产品及服务'
    )
    #4
    AdminChannel.create!(
      :parent_id    => nil,
      :typo         => 'article',
      :title        => '移动营销天地',
      :short_title  => 'blog',
      :properties   => 1,
      :tmp_index    => 'temp_blog_index.html',
      :tmp_detail   => 'temp_blog_detail.html',
      :default_url  => nil,
      :keywords     => '瑞信云移动营销天地',
      :description  => '瑞信云移动营销天地'
    )
    #5
    AdminChannel.create!(
      :parent_id    => nil,
      :typo         => 'article',
      :title        => '行业解决方案',
      :short_title  => 'case',
      :properties   => 1,
      :tmp_index    => 'temp_default.html',
      :tmp_detail   => 'temp_default.html',
      :default_url  => nil,
      :keywords     => '瑞信云产品及服务,行业解决方案',
      :description  => '瑞信云产品及服务,行业解决方案'
    )
    #6
    AdminChannel.create!(
      :parent_id    => nil,
      :typo         => 'product',
      :title        => '成功案例',
      :short_title  => 'portfolio',
      :properties   => 1,
      :tmp_index    => 'temp_portfolio_index.html',
      :tmp_detail   => 'temp_portfolio_detail.html',
      :default_url  => nil,
      :keywords     => '瑞信云成功案例',
      :description  => '瑞信云成功案例'
    )
    #7
    AdminChannel.create!(
      :parent_id    => nil,
      :typo         => 'article',
      :title        => '经销.加盟',
      :short_title  => 'join',
      :properties   => 1,
      :tmp_index    => 'temp_default.html',
      :tmp_detail   => 'temp_default.html',
      :default_url  => nil,
      :keywords     => '瑞信云经销商加盟',
      :description  => '瑞信云经销商加盟'
    )
    #3-1
    AdminChannel.create!(
      :parent_id    => 3,
      :typo         => 'article',
      :title        => '全方位网络营销托管',
      :short_title  => 'tuoguan',
      :properties   => 1,
      :tmp_index    => 'temp_default.html',
      :tmp_detail   => 'temp_default.html',
      :default_url  => nil,
      :keywords     => '瑞信云产品及服务,全方位网络营销托管',
      :description  => '瑞信云产品及服务,全方位网络营销托管'
    )
    AdminChannel.create!(
      :parent_id    => 3,
      :typo         => 'article',
      :title        => '手机应用开发(APP)',
      :short_title  => 'app',
      :properties   => 1,
      :tmp_index    => 'temp_default.html',
      :tmp_detail   => 'temp_default.html',
      :default_url  => nil,
      :keywords     => '瑞信云产品及服务,手机应用开发',
      :description  => '瑞信云产品及服务,手机应用开发,APP开发'
    )
    AdminChannel.create!(
      :parent_id    => 3,
      :typo         => 'article',
      :title        => '企业微信营销',
      :short_title  => 'weixin',
      :properties   => 1,
      :tmp_index    => 'temp_default.html',
      :tmp_detail   => 'temp_default.html',
      :default_url  => nil,
      :keywords     => '瑞信云产品及服务,企业微信营销',
      :description  => '瑞信云产品及服务,企业微信营销'
    )
    AdminChannel.create!(
      :parent_id    => 3,
      :typo         => 'article',
      :title        => '企业网站建设-RainCMS',
      :short_title  => 'raincms',
      :properties   => 1,
      :tmp_index    => 'temp_default.html',
      :tmp_detail   => 'temp_default.html',
      :default_url  => nil,
      :keywords     => '瑞信云产品及服务,企业营销型网站建设, RainCMS',
      :description  => '瑞信云产品及服务,企业营销型网站建设, RainCMS'
    )
    AdminChannel.create!(
      :parent_id    => 3,
      :typo         => 'article',
      :title        => '智能网络营销系统-雨服务',
      :short_title  => 'yufuwu',
      :properties   => 1,
      :tmp_index    => 'temp_default.html',
      :tmp_detail   => 'temp_default.html',
      :default_url  => nil,
      :keywords     => '瑞信云产品及服务,智能网络营销系统,雨服务',
      :description  => '瑞信云产品及服务,智能网络营销系统,雨服务'
    )
    #7-1
    AdminChannel.create!(
      :parent_id    => 7,
      :typo         => 'article',
      :title        => '经销加盟政策',
      :short_title  => 'join-zc',
      :properties   => 1,
      :tmp_index    => 'temp_default.html',
      :tmp_detail   => 'temp_default.html',
      :default_url  => nil,
      :keywords     => '瑞信云产品及服务,经销加盟政策',
      :description  => '瑞信云产品及服务,经销加盟政策'
    )
    AdminChannel.create!(
      :parent_id    => 7,
      :typo         => 'article',
      :title        => '经销加盟申请',
      :short_title  => 'join-up',
      :properties   => 1,
      :tmp_index    => 'temp_default.html',
      :tmp_detail   => 'temp_default.html',
      :default_url  => nil,
      :keywords     => '瑞信云产品及服务,经销加盟申请',
      :description  => '瑞信云产品及服务,经销加盟申请'
    )
    #2-1
    AdminChannel.create!(
      :parent_id    => 2,
      :typo         => 'article',
      :title        => '联系我们',
      :short_title  => 'contact',
      :properties   => 1,
      :tmp_index    => 'temp_default.html',
      :tmp_detail   => 'temp_default.html',
      :default_url  => nil,
      :keywords     => '联系瑞信云',
      :description  => '联系瑞信云'
    )
    
    puts "done!"
  end
end

#run script
DataExtractor.new(ARGV).run if __FILE__ == $0

# NSERT INTO admin_channels(parent_id, typo, title, short_title, properties, default_url, tmp_index, tmp_detail, keywords, description)
# VALUES(NULL, 'article', '首页', 'index', 1, NULL, 'temp_index.html', '', '首页', '首页');