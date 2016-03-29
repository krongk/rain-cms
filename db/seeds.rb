# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

#1. add default admin account
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

#2. init templete
puts 'init templetes'
Admin::Keystore.put('templete', 'default')
Admin::Keystore.put('site_name', 'Rain CMS')

#3. init contact info (option)
puts "init crm info"
Admin::Keystore.put('contact_name', '探码科技')
Admin::Keystore.put('contact_qq', '77632132')
Admin::Keystore.put('contact_wechat', 'xuejiang_song')
Admin::Keystore.put('contact_weibo', 'tanmer')
Admin::Keystore.put('weibo_url', 'http://www.weibo.com/tanmer')
Admin::Keystore.put('contact_mobile', '18080810818')
Admin::Keystore.put('contact_email', 'app@mesbo.cn')
Admin::Keystore.put('firm_name', '成都探码科技有限公司')

#4. init channel (option)
puts "create new channel"
Admin::Channel.create!(
  :parent_id    => nil,
  :typo         => 'article',
  :title        => '首页',
  :short_title  => 'index',
  :properties   => 1,
  :default_url  => nil,
  :tmp_index    => 'temp_index.html',
  :tmp_detail   => 'temp_detail.html',
  :keywords     => '首页',
  :description  => '欢迎使用RainCMS, 成都探码科技有限公司出品！'
)

Admin::Channel.create!(
  :parent_id    => nil,
  :typo         => 'product',
  :title        => '博客',
  :short_title  => 'blog',
  :properties   => 1,
  :default_url  => nil,
  :tmp_index    => 'temp_blog.html',
  :tmp_detail   => 'temp_detail.html',
  :keywords     => '博客列表',
  :description  => ''
)

