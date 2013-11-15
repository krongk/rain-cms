# Usage:
#
#   ruby site_test.rb -b 1
# => b is :batch_id

# Purpose:
  # For each unique domain, we need to check:
  # 1. Whether it's mobile optimize (check whether there's specific code to handle mobile view
  # 2. Take mobile screenshot of this website
  # 3. Find out whether this website is build by findlaw, lawyers.com, or justia (usually there's power by attribution at bottom of the homepage).
  # 4. Detect how big is the site (probably query google "site:avvo.com" parse # of pages returned by google

require 'rubygems'
require 'nokogiri'
require 'uri'
require 'optparse'
require 'active_record'
require 'chinese_pinyin'

class LocalTableBase < ActiveRecord::Base
  self.abstract_class = true
  self.pluralize_table_names = false
end

class CommonTableBase < ActiveRecord::Base
  self.abstract_class = true
  self.pluralize_table_names = false
end

CommonTableBase.establish_connection(
 :adapter => 'mysql2',
 :host => 'localhost',
 :username => 'root',
 :password => 'kenrome001',
 :database => 'raincms' 
)

LocalTableBase.establish_connection(
 :adapter => 'mysql2',
 :reconnect => true,
 :wait_timeout => 600,
 :pool => 50,
 :host => 'localhost',
 :username => 'root',
 :password => 'kenrome001',
 :database => 'forager' 
)

class Sunon < LocalTableBase
end
class AdminPage < CommonTableBase
  self.table_name = 'admin_pages'
end
class AdminChannel < CommonTableBase
  self.table_name = 'admin_channels'
end

class TestA
  def initialize(args)
    # opt = OptionParser.new
    # opt.on('-b', '--batch_id batch_id') { |batch_id| @batch_id = batch_id }
    # opt.parse!(args)
    # raise "please put batch_id with value [0,1,2,3]" if @batch_id.nil?

    # @profile = Selenium::WebDriver::Firefox::Profile.new
  end

  def run
    Sunon.where(is_processed: 'n').each do |sun|
      flag = 'f'
      channel = AdminChannel.find_by(title: sun.typo1)
      flag = 'no channel' if channel.nil?
      unless flag == 'no channel'
        page = AdminPage.new
        page.user_id = 1
        page.channel_id = channel.id 
        page.keywords = sun.typo2
        page.title = sun.name
        page.description = sun.description
        page.short_title = Pinyin.t(page.title).gsub(/\s+/, '-')
        page.image_path = sun.image2.to_s.sub(/http:\/\/www.sunon-china.com\/upload\//i, '/product_images/')
        page.content = get_content(sun)
        flag = 'y'
        page.save!
      end
      sun.is_processed = flag
      sun.save!
      puts sun.id.to_s + flag
    end
  end

  def get_content(sun)
    cont1 = %{
<div class="large-sl" id="slider">
  <!-- CONTROLS DIV CONTAINER ! NOT REMOVE -->
  <div class="portfolio-controls-single"></div>
  <!-- CONTROLS DIV CONTAINER ! NOT REMOVE -->
  <!-- BEGIN SLIDER UL -->
  <ul class="slides">
  }
    cont2 = %{
  </ul>
  <!-- END SLIDER UL -->
</div>
    }

    #
    str_arr = []

    sun.image1.to_s.split(/\n+/).each do |s|
      next unless s =~ /\d+.(jpg|png|gif)/i
      str_arr << %{ <!-- BEGIN SLIDE -->
              <li class="slide thumbnail">
                <img src="#{s.to_s.sub(/http:\/\/www.sunon-china.com\/upload\//i, '/product_images/')}" alt="#{sun.typo1}-#{sun.typo2}-#{sun.name}" />
              </li>
              <!-- END SLIDE -->}
    end

    cont3 = %{
      <!-- DESCRIPTION -->
          <div class="well">
            #{sun.seka}
          </div>
          <!-- END DESCRIPTION -->
    }

    return [cont1, str_arr.join("\n"), cont2, cont3].join("\n")
  end
end

TestA.new(ARGV).run 
