# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html
puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by(name: role)
  puts 'role: ' << role
end

puts 'DEFAULT USERS'
user = User.create(:name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup)
puts 'user: ' << user.name
#user.confirm!
user.add_role :admin

puts 'DEFAULT USERS'
user = User.create(:name => 'chemar', :email => 'chemar@qq.com', :password => 'chemar.com', :password_confirmation => 'chemar.com')
puts 'user: ' << user.name
#user.confirm!
user.add_role :admin

puts 'init templetes'
Admin::Keystore.put('templete', 'chemar')
Admin::Keystore.put('site_name', '车码儿')

puts "init crm info"
# Admin::Keystore.put('contact_name', '车码儿')
# Admin::Keystore.put('contact_qq', '77632132')
# Admin::Keystore.put('contact_wechat', 'xuejiang_song')
# Admin::Keystore.put('wechat_url', '微信关注网址')
# Admin::Keystore.put('contact_weibo', 'omero')
# Admin::Keystore.put('weibo_url', 'http://www.weibo.com/omero')
# Admin::Keystore.put('contact_mobile', '13981811358')
# Admin::Keystore.put('contact_email', '872342975@qq.com')
# Admin::Keystore.put('firm_name', '四川万邦欧美龙洗涤服务有限公司')
# Admin::Keystore.put('firm_phone', '4000-300-389')
# Admin::Keystore.put('firm_city', '成都市')
# Admin::Keystore.put('firm_address', '成都市双流县')

puts "create new channel"
Admin::Channel.create!(
  :parent_id    => nil,
  :typo         => 'article',
  :title        => '首页',
  :short_title  => 'index',
  :properties   => 1,
  :default_url  => nil,
  :tmp_index    => 'temp_index.html',
  :tmp_detail   => 'temp_index.html',
  :keywords     => '首页',
  :description  => ''
)

Admin::Channel.create!(
  :parent_id    => nil,
  :typo         => 'article',
  :title        => '使用教程',
  :short_title  => 'product',
  :properties   => 1,
  :default_url  => nil,
  :tmp_index    => 'temp_article_list.html',
  :tmp_detail   => 'temp_detail.html',
  :keywords     => '',
  :description  => ''
)

Admin::Channel.create!(
  :parent_id    => nil,
  :typo         => 'product',
  :title        => '行车安全',
  :short_title  => 'case',
  :properties   => 1,
  :default_url  => nil,
  :tmp_index    => 'temp_article_list.html',
  :tmp_detail   => 'temp_detail.html',
  :keywords     => '',
  :description  => ''
)

Admin::Channel.create!(
  :parent_id    => nil,
  :typo         => 'article',
  :title        => '交管动态',
  :short_title  => 'news',
  :properties   => 1,
  :default_url  => nil,
  :tmp_index    => 'temp_article_list.html',
  :tmp_detail   => 'temp_detail.html',
  :keywords     => '',
  :description  => ''
)




