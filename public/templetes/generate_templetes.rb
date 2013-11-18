#encoding: utf-8
# 该文件的目的是组装模板文件，生成一个演示预览：demo.html
#use $USAGE
$USAGE = <<EOT
 # 1. 请输入指定的模板文件名：-e theme
 # 2. 模板文件资源的文件结构为：
 #
 # |templete_name
 #        |assets
 #              _footer.html
 #              _header.html
 #              _index_content.html
 #              css_urls.txt
 #              js_urls.txt
 #        |css
 #        |js
 #        |img
 #        |pages
 #        |demo.default.html   
EOT

#or

#use RDoc::usage 
# == Synopsis
#

# mechanize lib
require 'rubygems'
require 'logger'
# command line argument parsing
require 'optparse'
require 'fileutils'
require 'pp'

# re-use Exception
class Exception
  attr_accessor :method_name
end

class ExtractException < Exception ; end

# define main class
class DataExtractor
  def print_and_exit(msg)
      puts
      puts '*** ERROR ***'
      puts msg
      puts
      exit
  end
  
  def initialize(args)
    print_and_exit($USAGE) if args.length == 0
    
    opt = OptionParser.new
    opt.on('-h', '--help') { print_and_exit($USAGE)}
    opt.on('-e', '--theme theme') { |theme| @theme = theme.downcase }
    opt.parse!(args)
    print_and_exit('please provide theme name with -e <theme>') if @theme.nil?
  end
  
  def run
    error_flag = false
    puts "generate #{@theme}........."

    #1. split index page
    index_path = File.join(File.dirname(__FILE__), @theme, 'index.html')
    head_path = File.join(File.dirname(__FILE__), @theme, '_head.html')
    header_path = File.join(File.dirname(__FILE__), @theme, '_header.html')
    foot_path = File.join(File.dirname(__FILE__), @theme, '_foot.html')
    footer_path = File.join(File.dirname(__FILE__), @theme, '_footer.html')
    puts "can not find index page #{error_flag = true}" unless File.exists?(index_path)
    return if error_flag

    index_content = File.open(index_path).read
    index_content.delete!("^\u{0000}-\u{007F}")
    %W[head foot header footer].each do |s|
      if /<!--\s*\[\[#{s} start\]\]\s*-->(.*)<!--\s*\[\[#{s} end\]\]-->/im =~ index_content.force_encoding("utf-8")
        the_content = $1
        File.open(eval("#{s}_path"), 'w'){|f| f.write( get_content(the_content) )}
        puts s
      else
        raise "error to find: " + s
      end
    end

    temp_index_path = File.join(File.dirname(__FILE__), @theme, 'temp_index.html')
    if /<body>(.*)<\/body>/im =~ index_content.force_encoding("utf-8")
      the_content = $1
      %W[header footer].each do |s|
        the_content = the_content.sub(/<!--\s*\[\[#{s} start\]\]\s*-->(.*)<!--\s*\[\[#{s} end\]\]\s*-->/im, "<%= render file: 'public/templetes/#{@theme}/_#{s}.html' %>")
      end
      File.open(temp_index_path, 'w'){|f| f.write( get_content(the_content) )}
    end

    #2. extract templete pages
    puts "extract templete pages--------------------"
    base_dir = File.join(File.dirname(__FILE__), @theme)
    Dir.chdir(base_dir)

    temp_list = Dir.glob("*.html")
    temp_list.each do |t|
      next if t !~ /^(?:t|temp)_(.*)$/i
      f_name = $1
      puts t

      the_content = File.open(t).read
      if /<body>(.*)<\/body>/im =~ the_content.force_encoding("utf-8")
        the_content = $1
        %W[header footer].each do |s|
          the_content = the_content.sub(/<!--\s*\[\[#{s} start\]\]\s*-->(.*)<!--\s*\[\[#{s}\s*end\]\] -->/im, "<%= render file: 'public/templetes/#{@theme}/_#{s}.html' %>")
        end
        File.open("temp_#{f_name}", 'w'){|f| f.write( get_content(the_content) )}
      end
    end
    puts "remove the arealdy processed temp files"
    FileUtils.rm_f Dir.glob("t_*.html")

    #3. extract other single page content
    #去除其他只保留body部分的main部分, 形式请参考temp_index.html
    puts "extract other single page ............"
    temp_list = Dir.glob("*.html")
    temp_list.each do |t|
      next if t =~ /^(?:t|temp)_(.*)$/i
      puts t

      the_content = File.open(t).read
      if /<!--\s*\[\[main start\]\]\s*-->(.*)<!--\s*\[\[main end\]\]\s*-->/im =~ the_content.force_encoding("utf-8")
        the_content = $1
        File.open(t, 'w'){|f| f.write( get_content(the_content) )}
      end
    end

    puts "............down!"
    exit
  end

  # <img src="assets/img
  # <script src="assets/js/b
  # <link href="assets/
  # <img src="images/
  def get_content(content)
    content.gsub!(/ src\s*=\s*"(assets|img|images|image|js|javascript|javascripts|css|font|ico|icon)\//, ' src="/templetes/{{theme}}/\1/')
    content.gsub!(/ href\s*=\s*"(assets|img|images|image|js|javascript|javascripts|css|font|ico|icon)\//, ' href="/templetes/{{theme}}/\1/')
    content.gsub!(/\{\{theme\}\}/, "#{@theme}")
    content
  end
end

#run script
DataExtractor.new(ARGV).run if __FILE__ == $0