class WelcomeController < ApplicationController
  layout 'frontpage'
  #{"controller"=>"welcome", "action"=>"index", "channel"=>"fw", "id"=>"2"}
  def index
    @channel = Admin::Channel.find_by(id: params[:channel])
    @channel ||=  Admin::Channel.first #first is the index
    @page = Admin::Page.find_by(id: params[:id])
  end

end
