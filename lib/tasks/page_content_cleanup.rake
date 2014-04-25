#encoding: utf-8
#xj: to fix image not responsive on mobile view
#1. remove style="height:576px; width:800px" /
#2. add class= "img-responsive"
#<img alt="面料" class="img-responsive" src="/ckeditor_assets/pictures/3/content.jpg" /><
#<img alt="" src="/ckeditor_assets/pictures/867/content.jpg" style="height:576px; width:800px" />
namespace :page do
  desc "to fix image not responsive on mobile view"
  task content_cleanup: :environment do
    Admin::Page.find_each do |page|
      begin
        doc = Nokogiri::HTML(page.content)
        doc.search("img").each do |img|
          img.remove_attribute("style")
          if img.attributes["class"].nil?
            img.set_attribute("class", "img-responsive")
          elsif (val = img.attribute("class").value) !~ /img-responsive/
            img.set_attribute("class", "#{val} img-responsive")
          end
        end
        page.content = doc.at("body").inner_html
        puts page.id
        page.save!
      rescue => ex
        puts ex.message
        puts page.id
      end
    end
  end
end

# u = "http://www.zxjj99.com/product-bed/392"
# doc = Nokogiri::HTML(open(u).read)
# doc.search("img")