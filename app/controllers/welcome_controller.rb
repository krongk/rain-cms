class WelcomeController < ApplicationController
  layout 'frontpage'
  #{"controller"=>"welcome", "action"=>"index", "channel"=>"fw", "id"=>"2"}
  def index
    @channel = Admin::Channel.find_by(short_title: params[:channel])
    @channel ||=  Admin::Channel.first #first is the index

    @page = Admin::Page.find_by(id: params[:id])
    @pages = @channel.pages.page(params[:page])
    # if @channel.nil? ||  @channel.properties == 3 && @page.nil?
    #   render action: :index
    # end
  end
end
