class Admin::PagesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_admin_page, only: [:show, :edit, :update, :destroy]

  # GET /admin/pages
  # GET /admin/pages.json
  def index
    @admin_pages = Admin::Page.all
  end

  # GET /admin/pages/1
  # GET /admin/pages/1.json
  def show
  end

  # GET /admin/pages/new
  def new
    @admin_page = Admin::Page.new
  end

  # GET /admin/pages/1/edit
  def edit
  end

  # POST /admin/pages
  # POST /admin/pages.json
  def create
    @admin_page = Admin::Page.new(admin_page_params)
    @admin_page.user_id = current_user.id

    respond_to do |format|
      if @admin_page.save
        update_tag

        format.html { redirect_to admin_pages_path, notice: '页面添加成功！' }
        format.json { render action: 'show', status: :created, location: @admin_page }
      else
        format.html { render action: 'new' }
        format.json { render json: @admin_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/pages/1
  # PATCH/PUT /admin/pages/1.json
  def update
    @admin_page.user_id = current_user.id
    respond_to do |format|
      if @admin_page.update(admin_page_params)
        update_tag

        format.html { redirect_to admin_pages_path, notice: '页面更新成功.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admin_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/pages/1
  # DELETE /admin/pages/1.json
  def destroy
    @admin_page.destroy
    respond_to do |format|
      format.html { redirect_to admin_pages_url }
      format.json { head :no_content }
    end
  end

  #Tag 用以下的符号隔开都可以，就是不能用空格
  def update_tag
    @admin_page.keywords.split(/(,|;|:|\.|\||\\|，|；|。|、)/).each do |tag|
      next if tag =~ /(,|;|:|\.|\||\\|，|；|。|、)/
      @admin_page.tag_list.add(tag)
      @admin_page.save!
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_page
      @admin_page = Admin::Page.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_page_params
      params.require(:admin_page).permit(:user_id, :channel_id, :title, :short_title, :properties, :keywords, 
        :description, :image_path, :content,
        :tag_id, :context, :taggable)
    end
end
