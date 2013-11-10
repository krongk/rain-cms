class WelcomeController < ApplicationController
  before_filter :load_templete
  #{"controller"=>"welcome", "action"=>"index", "channel"=>"fw", "id"=>"2"}
  def index
    @channel = Admin::Channel.find_by(id: params[:channel])
    @page = Admin::Page.find_by(id: params[:id])
  end

  def load_templete
    @templete = Admin::Keystore.value_for('templete')
  end
end
