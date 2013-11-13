class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :load_templete

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  private
  def load_templete
    @templete = Admin::Keystore.value_for('templete')
    @templete ||= 'default'

    @base_dir = "#{Rails.root}/public/templetes/#{@templete}/"
    Dir.chdir(@base_dir)
    @temp_list = Dir.glob("*.html")
  end

  def get_short_title(typo, title)
    return if title.blank?
    st = Pinyin.t(title).gsub(/(-|\s+)/, '-').gsub(/[^\w-]/, '')
    case typo
    when 'channel'
      while Admin::Channel.where(short_title: st).any?
        st += ('a'..'z').to_a[rand(26)]
      end
    when 'page'
      while Admin::Page.where(short_title: st).any?
        st += ('a'..'z').to_a[rand(26)]
      end
    else
      raise "Please put typo ['channel', 'page'] on method get_short_title"
    end
    return st
  end

end
