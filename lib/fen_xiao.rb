# 分销系统－－－获取总站数据到分站

#####define local module############
$:.unshift(File.dirname(__FILE__))
require 'rubygems'
require 'active_record'

module HeadSite
  
  class HeadSiteBase < ActiveRecord::Base
    self.abstract_class = true
    self.pluralize_table_names = false
    self.store_full_sti_class = false
  end
  
  HeadSiteBase.establish_connection(
    :adapter  => "mysql2",
    :host     => ENV['DB_HOST'],
    :port     => ENV['DB_PORT'].to_i,
    :username => ENV['DB_USERNAME'],
    :password => ENV['DB_PASSWORD'],
    :database => ENV['DB_DATABASE']
  )
  
  class Page < HeadSiteBase 
    self.table_name = 'admin_pages'
  end

end

class FenXiao
  def run(last_headquarter_id)
    puts ".....start get headquarter pages....."
    HeadSite::Page.where("id > ?", last_headquarter_id).order("id asc").each do |page|
      Admin::Forage.create!(
        title: page.title, 
        content: page.content,
        image_url: [ENV['HEADPARTER_SITE'], page.image_path].join('/').squeeze('/'), 
        original_url: [ENV['HEADPARTER_SITE'], page.channel_id, page.id].join('/').squeeze('/')
      )
      Admin::Keystore.put('fenxiao_page_count', page.id)
    end
  end
end

# GenerateProfileUrlHint.new.run if __FILE__ == $0
