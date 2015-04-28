class Ckeditor::Picture < Ckeditor::Asset
  has_attached_file :data,
                    :url  => "/ckeditor_assets/pictures/:id/:style.:extension",
                    :path => ":rails_root/public/ckeditor_assets/pictures/:id/:style.:extension",
                    :styles => { :content => '800>', :thumb => '270x180#' }

  validates_attachment_presence :data
  validates_attachment_size :data, :less_than => 2.megabytes
  validates_attachment_content_type :data, :content_type => /\Aimage/

  def url_content
    url(:content)
  end
end
