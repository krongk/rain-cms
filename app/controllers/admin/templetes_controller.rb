class Admin::TempletesController < ApplicationController

  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
    @file = File.join(@base_dir, params[:f])
    @file_content = File.open(@file, 'r').read
  end

  def update
    @file = File.join(@base_dir, params[:f])
    File.open(@file, 'w'){|f| f.write(params[:content])}
    redirect_to "/admin/templetes/index", notice: "更新成功"
  end

  def destroy
  end

end
