source 'https://ruby.taobao.org'
ruby '2.0.0'
gem 'rails', '~> 4.2.1'
gem 'sass-rails', '~> 5.0.3'
gem 'uglifier', '~> 2.7.1'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails', '4.0.3'
gem 'turbolinks', '2.5.3'
gem 'jbuilder', '~> 2.2.13'
gem 'bootstrap-sass', '~> 3.3.4.1'
gem 'bootstrap-will_paginate'
gem 'font-awesome-rails', '4.3.0.0'
gem 'cancan', '1.6.10'
gem 'devise', '3.4.1'
gem 'figaro', '1.1.0'
gem 'mysql2', '0.3.13'
gem 'rolify', '4.0.0'
gem 'simple_form', '3.1.0'
gem 'acts-as-taggable-on', '3.5.0'
gem 'sitemap_generator', '5.0.5'
gem 'whenever', :require => false
# For linux
gem 'therubyracer', :platform=>:ruby

#page caching
# http://www.rubytutorial.io/page-caching-with-rails-4
gem 'actionpack-page_caching'
#gem 'rails-observers' #manually remove the cache pages on raincms

#Liquid templete html
#gem 'liquid'

gem 'bower-rails'

#add :git to bugfix open dialog error
#gem "ckeditor", :git => "git@github.com:galetahub/ckeditor.git"
gem 'ckeditor', github: 'galetahub/ckeditor'
#File upload
gem 'paperclip'
gem 'paperclip-qiniu'

#Excel processing
# gem 'roo', '>=1.11.2' 
# gem 'rubyzip', "~> 0.9.9" #fix the error: cannot load such file -- zip/zipfilesystem

#Wizard
#gem 'wicked'


#I18n
gem 'rails-i18n', github: 'svenfuchs/rails-i18n', branch: 'master' # For 4.x
gem 'i18n_yaml_generator'

#Queue
gem 'sidekiq'

#Markdown syntax
gem "nokogiri"
gem "htmlentities"
#gem 'slodown'

#Send Mail
#gem 'mailgun'

#Pinyin.t('中国', splitter: '-') => "zhong-guo"
gem 'chinese_pinyin'

#wechat 
#gem 'weixin_authorize'

group :development do
  gem 'pry'
  gem 'pry-byebug'
  gem 'better_errors'
  gem 'web-console', '~> 2.0'
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :mri_20, :rbx]
  gem 'hub', :require=>nil
  gem 'quiet_assets'
  gem 'rails_layout'
end
group :development, :test do
  gem 'rspec-rails'
  gem 'capistrano-rvm'
  gem 'capistrano-rails'
  gem 'capistrano-passenger'
end
group :test do
  gem 'database_cleaner', '1.0.1'
  gem 'email_spec'
end
