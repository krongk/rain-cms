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

puts 'init templetes'
Admin::Keystore.put('templete', 'default')
Admin::Keystore.put('site_name', 'Rain CMS')

puts "init crm info"
Admin::Keystore.put('contact_name', '宋学江')
Admin::Keystore.put('contact_qq', '156090284')
Admin::Keystore.put('contact_wechat', 'xuejiang_song')
Admin::Keystore.put('wechat_url', '微信关注网址')
Admin::Keystore.put('contact_weibo', 'inruby')
Admin::Keystore.put('weibo_url', 'http://www.weibo.com/inruby')
Admin::Keystore.put('contact_mobile', '18280673990')
Admin::Keystore.put('contact_email', '156090284@qq.com')
Admin::Keystore.put('firm_name', '成都yizhilia')
Admin::Keystore.put('firm_address', '成都市高新区天益街38号理想中心1栋13层1308号')
Admin::Keystore.put('firm_phone', '028-82008001')
Admin::Keystore.put('firm_city', '成都市')
Admin::Keystore.put('firm_address', '高新区天益街38号理想中心1栋13层1308号')

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
