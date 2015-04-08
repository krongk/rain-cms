class CommentsController < ApplicationController
  before_filter :authenticate_user!, except: [:new, :create]
  before_action :set_channel, only: [:new, :create]
  layout 'frontpage'

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        if ENV['SMS_TOGGLE']
          SmsSendWorker.perform_async(ENV['SMS_PHONE'].split('|').join(','), "【#{ENV['SITE_NAME']}】#{@comment.mobile_phone}#{@comment.content.nil? ? '希望你尽快与他取得联系' : @comment.content.to_s.truncate(36)}")
          SmsSendWorker.perform_async(@comment.mobile_phone, "【#{ENV['SITE_NAME']}】您的联络人员手机号为#{ENV['CONTACT_MOBILE']}, 我们会尽快与您取得联系！")
        end
        format.html { redirect_to "/", notice: '留言成功.' }
        format.json { render action: 'show', status: :created, location: @comment }
      else
        format.html { render action: 'new' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use for frontpage layout.
    def set_channel
      @channel = Admin::Channel.first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:name, :mobile_phone, :tel_phone, :email, :qq, :address, :gender, :birth, :hobby, :content, :content2, :content3, :status)
    end
end
