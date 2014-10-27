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
 :host => 'localhost',
 :port => 3306,
 :database => 'shengmei' 
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
      :keywords     => '盛美农业,资阳市盛美农业有限责任公司,生猪养殖,苗木种植,水产养殖,家禽养殖,生态农业',
      :description  => '资阳市盛美农业有限责任公司是一家集生猪养殖,苗木种植,水产养殖,家禽养殖为一体的大型生态农业基地'
    )
    #2
    AdminChannel.create!(
      :parent_id    => nil,
      :typo         => 'product',
      :title        => '经营项目',
      :short_title  => 'product',
      :properties   => 1,
      :tmp_index    => 'temp_product_list.html',
      :tmp_detail   => 'temp_detail.html',
      :default_url  => nil,
      :keywords     => '盛美农业产品，经营项目',
      :description  => '资阳市盛美农业有限责任公司注册资本1600万元，经营范围主要是苗木花卉种植、销售；蔬菜、瓜果种植、销售；种畜禽生产繁殖、销售；水产养殖、销售；粮食收购等项目'
    )
    #3
    AdminChannel.create!(
      :parent_id    => nil,
      :typo         => 'article',
      :title        => '新闻中心',
      :short_title  => 'news',
      :properties   => 1,
      :tmp_index    => 'temp_blog_list.html',
      :tmp_detail   => 'temp_detail.html',
      :default_url  => nil,
      :keywords     => '盛美农业新闻中心',
      :description  => '资阳市盛美农业有限责任公司是一家集生猪养殖,苗木种植,水产养殖,家禽养殖为一体的大型生态农业基地'
    )
    #4
    AdminChannel.create!(
      :parent_id    => nil,
      :typo         => 'article',
      :title        => '关于我们',
      :short_title  => 'about',
      :properties   => 1,
      :tmp_index    => 'temp_blog_list.html',
      :tmp_detail   => 'temp_detail.html',
      :default_url  => nil,
      :keywords     => '关于盛美农业',
      :description  => '资阳市盛美农业有限责任公司是一家集生猪养殖,苗木种植,水产养殖,家禽养殖为一体的大型生态农业基地，册资本1600万元'
    )
 
    #2-1
    AdminChannel.create!(
      :parent_id    => 2,
      :typo         => 'product',
      :title        => '生猪养殖',
      :short_title  => 'product-pig',
      :properties   => 1,
      :tmp_index    => 'temp_product_list.html',
      :tmp_detail   => 'temp_detail.html',
      :default_url  => nil,
      :keywords     => '生猪养殖',
      :description  => '盛美农业公司生猪养殖场占地面积约100亩，建筑面积约为47000平方米。主要品种有加系和新美系长白、大白、杜洛克.'
    )
    #2-2
    AdminChannel.create!(
      :parent_id    => 2,
      :typo         => 'product',
      :title        => '苗木种植',
      :short_title  => 'product-miaomu',
      :properties   => 1,
      :tmp_index    => 'temp_product_list.html',
      :tmp_detail   => 'temp_detail.html',
      :default_url  => nil,
      :keywords     => '苗木种植基地',
      :description  => '盛美农业公司苗木种植基地约2000亩，主要以经济苗木为主，品种有桂花、银杏等各类珍稀苗木.'
    )
     #2-3
    AdminChannel.create!(
      :parent_id    => 2,
      :typo         => 'product',
      :title        => '水产养殖',
      :short_title  => 'product-shuichan',
      :properties   => 1,
      :tmp_index    => 'temp_product_list.html',
      :tmp_detail   => 'temp_detail.html',
      :default_url  => nil,
      :keywords     => '水产养殖基地',
      :description  => '盛美农业公司现有水产养殖基地3个，分布于资阳市老鹰水库、保和镇富家山村、简阳市杨家沟，占地面积约190亩；主要采用流水养鱼，主要以匙吻鲟、胭脂鱼、鲈鱼等各类名贵鱼种为主.'
    )
     #2-4
    AdminChannel.create!(
      :parent_id    => 2,
      :typo         => 'product',
      :title        => '家禽养殖',
      :short_title  => 'product-jiaqin',
      :properties   => 1,
      :tmp_index    => 'temp_product_list.html',
      :tmp_detail   => 'temp_detail.html',
      :default_url  => nil,
      :keywords     => '家禽养殖基地',
      :description  => '盛美农业公司家禽养殖基地占地1000余亩，利用优质土鸡苗，天然的驯养、放牧桂花林下，让土鸡回归自然环境放牧、生长，又以补饲玉米、豆粕、稻谷、青草、糠麸等杂粮为主要饲料.'
    )
   
    #3-1
    AdminChannel.create!(
      :parent_id    => 3,
      :typo         => 'article',
      :title        => '公司新闻',
      :short_title  => 'news-company',
      :properties   => 1,
      :tmp_index    => 'temp_blog_list.html',
      :tmp_detail   => 'temp_detail.html',
      :default_url  => nil,
      :keywords     => '盛美农业新闻,盛美农业新闻资讯，生态农业，西部农业行业动态',
      :description  => '盛美农业资讯提供盛美农业新闻资讯，西部农业行业动态，盛美农业公司新闻等资讯'
    )
    #3-2
    AdminChannel.create!(
      :parent_id    => 3,
      :typo         => 'article',
      :title        => '媒体报道',
      :short_title  => 'news-baodao',
      :properties   => 1,
      :tmp_index    => 'temp_blog_list.html',
      :tmp_detail   => 'temp_detail.html',
      :default_url  => nil,
      :keywords     => '盛美农业媒体新闻,盛美农业新闻资讯，生态农业，西部农业行业动态',
      :description  => '盛美农业媒体资讯提供盛美农业新闻资讯，西部农业行业动态，盛美农业公司新闻等资讯'
    )
    #3-3
    AdminChannel.create!(
      :parent_id    => 3,
      :typo         => 'article',
      :title        => '行业知识',
      :short_title  => 'news-hangye',
      :properties   => 1,
      :tmp_index    => 'temp_blog_list.html',
      :tmp_detail   => 'temp_detail.html',
      :default_url  => nil,
      :keywords     => '盛美农业行业新闻,盛美农业行业资讯，生态农业行业，西部农业行业动态',
      :description  => '盛美农业行业资讯提供盛美农业新闻资讯，西部农业行业动态，盛美农业公司新闻等资讯'
    )

    #4-1
    AdminChannel.create!(
      :parent_id    => 4,
      :typo         => 'article',
      :title        => '企业简介',
      :short_title  => 'jianjie',
      :properties   => 1,
      :tmp_index    => 'temp_detail.html',
      :tmp_detail   => 'temp_detail.html',
      :default_url  => nil,
      :keywords     => '资阳市盛美农业有限责任公司',
      :description  => '资阳市盛美农业有限责任公司是一家集生猪养殖,苗木种植,水产养殖,家禽养殖为一体的大型生态农业基地，册资本1600万元'
    )
    #4-2
    AdminChannel.create!(
      :parent_id    => 4,
      :typo         => 'article',
      :title        => '资质荣誉',
      :short_title  => 'zizhi',
      :properties   => 1,
      :tmp_index    => 'temp_detail.html',
      :tmp_detail   => 'temp_detail.html',
      :default_url  => nil,
      :keywords     => '资阳市盛美农业有限责任公司资质荣誉',
      :description  => '资阳市盛美农业有限责任公司是一家集生猪养殖,苗木种植,水产养殖,家禽养殖为一体的大型生态农业基地，册资本1600万元'
    )
    #4-3
    AdminChannel.create!(
      :parent_id    => 4,
      :typo         => 'article',
      :title        => '员工风采',
      :short_title  => 'fengcai',
      :properties   => 1,
      :tmp_index    => 'temp_detail.html',
      :tmp_detail   => 'temp_detail.html',
      :default_url  => nil,
      :keywords     => '资阳市盛美农业有限责任公司员工风采',
      :description  => '资阳市盛美农业有限责任公司是一家集生猪养殖,苗木种植,水产养殖,家禽养殖为一体的大型生态农业基地，册资本1600万元'
    )

    puts "done!"
  end
end


#run script
DataExtractor.new(ARGV).run if __FILE__ == $0

# NSERT INTO admin_channels(parent_id, typo, title, short_title, properties, default_url, tmp_index, tmp_detail, keywords, description)
# VALUES(NULL, 'article', '首页', 'index', 1, NULL, 'temp_index.html', '', '首页', '首页');
