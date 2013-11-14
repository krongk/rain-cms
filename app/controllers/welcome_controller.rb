class WelcomeController < ApplicationController
  layout 'frontpage'
  #{"controller"=>"welcome", "action"=>"index", "channel"=>"fw", "id"=>"2"}
  def index
    #page first, then channel ?
    if params[:id]
      @page = Admin::Page.find_by(id: params[:id])
    end
    @channel = @page.channel if @page

    #short_title use for frontpage cache
    @channel ||= Admin::Channel.find_by(id: params[:channel])
    #id use for previous
    @channel ||= Admin::Channel.find_by(short_title: params[:channel])
    #first is index page
    @channel ||= Admin::Channel.first

    if @channel.nil?
      redirect_to "/admin/channels/new", notice: "没有任何内容，请在后台添加" and return
    end
    #@page = Admin::Page.find_by(id: params[:id])
    @pages = @channel.pages.page(params[:page])
    # if @channel.nil? ||  @channel.properties == 3 && @page.nil?
    #   render action: :index
    # end
    #render text: "#{@channel.id} - #{@page.id}" and return
  end
end
