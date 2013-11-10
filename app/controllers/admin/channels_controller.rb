class Admin::ChannelsController < ApplicationController
  before_action :set_admin_channel, only: [:show, :edit, :update, :destroy]

  # GET /admin/channels
  # GET /admin/channels.json
  def index
    @admin_channels = Admin::Channel.all
  end

  # GET /admin/channels/1
  # GET /admin/channels/1.json
  def show
  end

  # GET /admin/channels/new
  def new
    @admin_channel = Admin::Channel.new
  end

  # GET /admin/channels/1/edit
  def edit
  end

  # POST /admin/channels
  # POST /admin/channels.json
  def create
    @admin_channel = Admin::Channel.new(admin_channel_params)

    respond_to do |format|
      if @admin_channel.save
        format.html { redirect_to @admin_channel, notice: 'Channel was successfully created.' }
        format.json { render action: 'show', status: :created, location: @admin_channel }
      else
        format.html { render action: 'new' }
        format.json { render json: @admin_channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/channels/1
  # PATCH/PUT /admin/channels/1.json
  def update
    respond_to do |format|
      if @admin_channel.update(admin_channel_params)
        format.html { redirect_to @admin_channel, notice: 'Channel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admin_channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/channels/1
  # DELETE /admin/channels/1.json
  def destroy
    @admin_channel.destroy
    respond_to do |format|
      format.html { redirect_to admin_channels_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_channel
      @admin_channel = Admin::Channel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_channel_params
      params.require(:admin_channel).permit(:user_id, :cate_type, :title, :properties, :default_index, :tmp_index, :tmp_list, :tmp_detial, :keywords, :description, :content)
    end
end
