module ApplicationHelper
  PAGE_PROPERTIES = [
    ['H', '头条'],
    ['C', '推荐'],
    ['F', '幻灯'],
    ['D', '底部'],
    ['S', '滚动'],
    ['B', '加粗'],
    ['P', '图片'],
    ['J', '跳转'],
  ]

  SPECIAL_SYMBO_REG = /(,|;|:|\.|\||\\|，|；|。|、)/

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  def title(page_title)
    content_for(:title){ page_title}
  end
  def meta_keywords(meta_keywords)
    content_for(:meta_keywords){ meta_keywords}
  end
  def meta_description(meta_description)
    content_for(:meta_description){ meta_description}
  end

  def get_templete(temp_name, page_name, partial = false )
    f = "#{Rails.root}/public/templetes/#{temp_name}/#{if partial then '_' end}#{page_name}"
    File.exist?(f) ? f : 'layouts/blank'
  end
  
end
