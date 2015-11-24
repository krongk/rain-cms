# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html
# puts 'ROLES'
# YAML.load(ENV['ROLES']).each do |role|
#   Role.find_or_create_by(name: role)
#   puts 'role: ' << role
# end

# puts 'DEFAULT USERS'
# user = User.create(:name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup)
# puts 'user: ' << user.name
# #user.confirm!
# user.add_role :admin

# puts 'DEFAULT USERS'
# user = User.create(:name => 'song', :email => 'song@tanmer.com', :password => 'tanmer.com', :password_confirmation => 'tanmer.com')
# puts 'user: ' << user.name
# #user.confirm!
# user.add_role :admin

# puts 'DEFAULT USERS'
# user = User.create(:name => 'xiaohui', :email => 'xiaohui@tanmer.com', :password => 'tanmer.com', :password_confirmation => 'tanmer.com')
# puts 'user: ' << user.name
# #user.confirm!
# user.add_role :admin

# puts 'init templetes'
# Admin::Keystore.put('templete', 'tanmer')
# Admin::Keystore.put('site_name', '探码科技')

# puts "init crm info"
# Admin::Keystore.put('contact_name', '探码科技')
# Admin::Keystore.put('contact_qq', '77632132')
# Admin::Keystore.put('contact_wechat', 'xuejiang_song')
# Admin::Keystore.put('contact_weibo', 'tanmer')
# Admin::Keystore.put('weibo_url', 'http://www.weibo.com/tanmer')
# Admin::Keystore.put('contact_mobile', '18080810818')
# Admin::Keystore.put('contact_email', 'song@tanmer.com')
# Admin::Keystore.put('firm_name', '成都探码科技有限公司')

# puts "create new channel"
# Admin::Channel.create!(
#   :parent_id    => nil,
#   :typo         => 'article',
#   :title        => '首页',
#   :short_title  => 'index',
#   :properties   => 1,
#   :default_url  => nil,
#   :tmp_index    => 'temp_index.html',
#   :tmp_detail   => 'temp_index.html',
#   :keywords     => '首页',
#   :description  => ''
# )

# Admin::Channel.create!(
#   :parent_id    => nil,
#   :typo         => 'article',
#   :title        => '智慧城市',
#   :short_title  => 'bigdata',
#   :properties   => 1,
#   :default_url  => nil,
#   :tmp_index    => 'temp_work_list.html',
#   :tmp_detail   => 'temp_detail.html',
#   :keywords     => '智慧城市，大数据，物联网，云计算',
#   :description  => '智慧城市是运用物联网、云计算、大数据、空间地理信息集成等新一代信息技术，促进城市规划、建设、管理和服务智慧化的新理念和新模式'
# )

# Admin::Channel.create!(
#   :parent_id    => nil,
#   :typo         => 'article',
#   :title        => '互联网O2O',
#   :short_title  => 'net',
#   :properties   => 1,
#   :default_url  => nil,
#   :tmp_index    => 'temp_work_list.html',
#   :tmp_detail   => 'temp_detail.html',
#   :keywords     => '互联网加，企业互联网转型，企业O2O，整合营销',
#   :description  => '专注中小企业“互联网＋”转型服务，让企业的“互联网+”转型不再困惑'
# )

# Admin::Channel.create!(
#   :parent_id    => nil,
#   :typo         => 'article',
#   :title        => '品牌内容定制',
#   :short_title  => 'brand',
#   :properties   => 1,
#   :default_url  => nil,
#   :tmp_index    => 'temp_work_list.html',
#   :tmp_detail   => 'temp_detail.html',
#   :keywords     => '新媒体，原生广告，品牌策划，品牌建设，内容工厂',
#   :description  => '自媒体社群经济下的品牌战略，颠覆传统广告的新生态营销'
# )

# Admin::Channel.create!(
#   :parent_id    => nil,
#   :typo         => 'article',
#   :title        => '团队',
#   :short_title  => 'team',
#   :properties   => 1,
#   :default_url  => nil,
#   :tmp_index    => 'temp_team_list.html',
#   :tmp_detail   => 'temp_detail.html',
#   :keywords     => '',
#   :description  => ''
# )

# Admin::Channel.create!(
#   :parent_id    => nil,
#   :typo         => 'article',
#   :title        => '最新动态',
#   :short_title  => 'news',
#   :properties   => 1,
#   :default_url  => nil,
#   :tmp_index    => 'temp_news_list.html',
#   :tmp_detail   => 'temp_detail.html',
#   :keywords     => '',
#   :description  => ''
# )



Admin::Channel.create!(
  :parent_id    => 1,
  :typo         => 'article',
  :title        => '关于我们',
  :short_title  => 'about',
  :properties   => 1,
  :default_url  => nil,
  :tmp_index    => 'temp_about.html',
  :tmp_detail   => 'temp_detail.html',
  :keywords     => '',
  :description  => ''
)


Admin::Channel.create!(
  :parent_id    => nil,
  :typo         => 'article',
  :title        => '工作案例',
  :short_title  => 'case',
  :properties   => 1,
  :default_url  => nil,
  :tmp_index    => 'temp_case_list.html',
  :tmp_detail   => 'temp_detail.html',
  :keywords     => '',
  :description  => ''
)

Admin::Channel.create!(
  :parent_id    => nil,
  :typo         => 'article',
  :title        => 'Blog',
  :short_title  => 'blog',
  :properties   => 1,
  :default_url  => nil,
  :tmp_index    => 'temp_news_list.html',
  :tmp_detail   => 'temp_detail.html',
  :keywords     => '',
  :description  => ''
)




