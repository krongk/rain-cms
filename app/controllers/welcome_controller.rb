class WelcomeController < ApplicationController
  caches_page :index
  
  layout 'frontpage'

  #{"controller"=>"welcome", "action"=>"index", "channel"=>"fw", "id"=>"2", "tag" => "tagkey"}
  def index
    #render text: params and return
   
    #page first, then channel ?
    if params[:id]
      @page = Admin::Page.find_by(id: params[:id])
    end
    @channel = @page.channel if @page

    #short_title use for frontpage cache
    @channel ||= Admin::Channel.find_by(id: params[:channel])
    #id use for previous
    @channel ||= Admin::Channel.find_by(short_title: params[:channel])
    #root index.html
    if params.delete_if {|k, v| ['controller', 'action'].include?(k)}.empty?
      @channel ||= Admin::Channel.first 
    end
    
    not_found if @channel.nil?

    #pages
    if params[:tag]
      @pages = Admin::Page.tagged_with(params[:tag]).page(params[:page])
    else
      @pages = @channel.pages.order("updated_at DESC").page(params[:page])
    end
    #tag cloud
    @tags = Admin::Page.tag_counts_on(:tags)
  end
end
