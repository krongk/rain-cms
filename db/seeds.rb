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
  Role.find_or_create_by_name(role)
  puts 'role: ' << role
end

puts 'DEFAULT USERS'
user = User.find_or_create_by_email :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
puts 'user: ' << user.name
#user.confirm!
user.add_role :admin

puts 'init templetes'
Admin::Keystore.put('templete', 'default')
Admin::Keystore.put('site_name', 'Rain CMS')

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