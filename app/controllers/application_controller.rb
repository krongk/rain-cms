class ApplicationController < ActionController::Base
  include ApplicationHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :load_templete

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  private
  #this method initlize global variables.
  def load_templete
    @templete = Admin::Keystore.value_for('templete')
    @templete ||= 'default'
    @base_dir = "#{Rails.root}/public/templetes/#{@templete}/"
    Dir.chdir(@base_dir)
    @temp_list = Dir.glob("*.html").sort

    #imgfiles = File.join(@base_dir, "**", "*.{jpg, png, gif, jpeg}")
    @image_list = Rails.cache.read('image_list')
    unless @image_list
      assetfiles = File.join(Rails.root, "public", "**", "*.{jpg, png, gif, jpeg}")
      @image_list = Dir.glob(assetfiles).map{|i| i.sub(/^.*\/public/, '') }.sort
      Rails.cache.write('image_list', @image_list)
    end
  end
  
  def load_templete_bak
    @templete = Rails.cache.read('templete')
    unless @templete
      @templete = Admin::Keystore.value_for('templete')
      @templete ||= 'default'
      Rails.cache.write('templete', @templete)
    end

    @base_dir = Rails.cache.read('base_dir')
    unless @base_dir
      @base_dir = "#{Rails.root}/public/templetes/#{@templete}/"
      Rails.cache.write('base_dir', @base_dir)
    end

    @temp_list = Rails.cache.read('temp_list')
    unless @temp_list
      Dir.chdir(@base_dir)
      @temp_list = Dir.glob("*.html").sort
      Rails.cache.write('temp_list', @temp_list)
    end
  end
end
