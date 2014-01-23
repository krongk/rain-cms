#encoding: utf-8
require 'rubygems'
require 'optparse'
require 'active_record'
################################################
class LocalTableBase < ActiveRecord::Base
  self.abstract_class = true
  self.pluralize_table_names = false
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
 :database => 'forager' 
)

class Zhixin < LocalTableBase
  self.table_name = 'zhixin'
end

################################################

class CommonTableBase < ActiveRecord::Base
  self.abstract_class = true
  #self.pluralize_table_names = false
end

CommonTableBase.establish_connection(
 :adapter => 'mysql2',
 :reconnect => true,
 :wait_timeout => 600,
 :pool => 50,
 :username => 'root',
 :password => 'kenrome001',
 :host => 'localhost',
 :port => 3306,
 :database => 'zhixin' 
)

class AdminPage < CommonTableBase
  self.table_name = 'admin_pages'
end

#################################
class Test

  def runb
    i = 0
    Zhixin.find_each do |p|
      content = p.content.gsub(/\n+\s*([一二三四五六七八九十123456789].*)\s*\n+/, '<h2>\1</h2>')
      content = content.gsub(/\n/, "<br>\n")
      p.html = content
      p.save!
      puts p.id
      i += 1
      break if i > 10000
    end
  end

  def runa
    i = 0
    Zhixin.where("is_processed = 'n'").find_each do |p|
      a = AdminPage.new
      a.user_id = 1
      a.channel_id = 41
      a.title = p.title
      a.keywords = p.keywords
      a.content = p.html
      # if Admin::Keystore.value_for('news_pictures')
      #   a.image_path = "/news_pictures/#{Admin::Keystore.value_for('news_pictures')}.jpg"
      #   Admin::Keystore.increment_value_for('news_pictures')
      # end
      a.save!
      p.is_processed = 'y'
      p.save!
      puts a.reload.id
      i += 1
      break if i > 3
    end
  end

end

Test.new.runa if $0 == __FILE__