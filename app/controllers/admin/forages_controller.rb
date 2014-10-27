class Admin::ForagesController < Admin::ApplicationController
  include ActionView::Helpers::TextHelper #simple_format
  include ActionView::Helpers::OutputSafetyHelper #raw

  before_action :set_admin_forage, only: [:show, :edit, :update, :destroy]

  # GET /admin/forages
  # GET /admin/forages.json
  def index
    @admin_forages = Admin::Forage.page(params[:page])
  end

  # GET /admin/forages/1
  # GET /admin/forages/1.json
  def show
  end

  # GET /admin/forages/new
  def new
    @admin_forage = Admin::Forage.new
  end

  # GET /admin/forages/1/edit
  def edit
  end

  # POST /admin/forages
  # POST /admin/forages.json
  def create
    @admin_forage = Admin::Forage.new(admin_forage_params)

    respond_to do |format|
      if @admin_forage.save
        format.html { redirect_to admin_forages_path, notice: '采集数据添加成功.' }
        format.json { render action: 'show', status: :created, location: @admin_forage }
      else
        format.html { render action: 'new' }
        format.json { render json: @admin_forage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/forages/1
  # PATCH/PUT /admin/forages/1.json
  # "admin_forage"=>{"title"=>"FWEf", "content"=>"awfwfe", "tag"=>"ewf", "author"=>"fw", "original_url"=>"wfawf", "channel_id"=>"6"}
  def update
    admin_forage = Admin::Forage.find(params[:id])
    @admin_page = Admin::Page.create(
      user_id: current_user.id,
      channel_id: params[:admin_forage].delete(:channel_id),
      short_title: get_short_title('page', params[:admin_forage][:title]),
      title: params[:admin_forage].delete(:title), 
      content: simple_format(params[:admin_forage].delete(:content)), 
      image_path: params[:admin_forage].delete(:image_url), 
      keywords: params[:admin_forage].delete(:tag)
    )
    respond_to do |format|
      if @admin_page.present?
        admin_forage.destroy

        format.html { redirect_to edit_admin_page_path(@admin_page), notice: '数据合并成功，请修改格式并保存.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admin_forage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/forages/1
  # DELETE /admin/forages/1.json
  def destroy
    @admin_forage.destroy
    respond_to do |format|
      format.html { redirect_to admin_forages_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_forage
      @admin_forage = Admin::Forage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_forage_params
      params.require(:admin_forage).permit(:channel_id, :title, :content, :tag, :author, :image_url, :original_url)
    end
end
