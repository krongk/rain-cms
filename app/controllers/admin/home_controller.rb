class Admin::HomeController < Admin::ApplicationController
  def ckeditor_pictures
    @images = Ckeditor::Picture.order("updated_at DESC").page(params[:page])
  end

  def help
  end

  #获取分销总部数据
  def fenxiao_headquarter
    if Admin::Keystore.get('fenxiao_page_count').nil?
      Admin::Keystore.put('fenxiao_page_count', 0)
    end
    last_headquarter_id = [Admin::Keystore.value_for('fenxiao_page_count').to_i, Admin::Page.maximum(:headquarter_id)].max
    FenXiaoWorker.perform_async(last_headquarter_id)
    render text:  "数据正在处理中...<a href='/admin/forages'>点击这里返回查看</a>"
  end
end
