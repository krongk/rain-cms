#encoding: utf-8
class Admin::TempletesController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def show
  end

  def new
    @templetes = Dir.glob "#{Rails.root}/public/templetes/*"
  end

  def create
    Admin::Keystore.put('templete', params[:templete])
    #Admin::Keystore.put('head', params[:head])
    #Admin::Keystore.put('foot', params[:foot])
    #input layouts/_header
    File.open( File.join(Rails.root, "/app/views/layouts/_header.html.erb"), 'w') do |f|
      f.write File.open( File.join(@base_dir, '_header.html'), 'r').read
    end
    File.open( File.join(Rails.root, "/app/views/layouts/_footer.html.erb"), 'w') do |f|
      f.write File.open( File.join(@base_dir, '_footer.html'), 'r').read
    end
    redirect_to "/admin/templetes/index", notice: "添加成功"
  end

  def edit
    @file = File.join(@base_dir, params[:f])
    @file_content = File.open(@file, 'r').read
  end

  def update
    @file = File.join(@base_dir, params[:f])
    File.open(@file, 'w'){|f| f.write(params[:content])}
    redirect_to "/admin/templetes/index", notice: "更新成功"
    expire_cache
  end

  def destroy
  end

  private
  def expire_cache
    cache_index_path = File.join(Rails.root, 'public', 'index.html')
    FileUtils.rm_rf cache_index_path if File.exist?(cache_index_path)

    Admin::Channel.find_each do |channel|
      cache_page_path = File.join(Rails.root, 'public', channel.short_title + '.html')
      cache_page_dir = File.join(Rails.root, 'public', channel.short_title)
      FileUtils.rm_rf cache_page_path if File.exist?(cache_page_path)
      FileUtils.rm_rf cache_page_dir if File.exist?(cache_page_dir)
      
      cache_page_id_path = File.join(Rails.root, 'public', channel.id.to_s + '.html')
      cache_page_id_dir = File.join(Rails.root, 'public', channel.id.to_s)
      FileUtils.rm_rf cache_page_id_path if File.exist?(cache_page_id_path)
      FileUtils.rm_rf cache_page_id_dir if File.exist?(cache_page_id_dir)
    end
  end

end
