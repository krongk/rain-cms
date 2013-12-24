class ApplicationController < ActionController::Base
  include ApplicationHelper
  #add page cache
  include ActionController::Caching::Pages
  self.page_cache_directory = "#{Rails.root.to_s}/public/page_cache"

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

    tempfiles = File.join(Rails.root, "public", "ckeditor_assets", "**", "*.{jpg, png, gif, jpeg}")
    @image_list = Dir.glob([tempfiles]).map{|i| i.sub(/^.*\/public/, '') }.sort
  end

  #render 404 error
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

end
