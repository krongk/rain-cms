json.array!(@admin_pages) do |admin_page|
  json.extract! admin_page, :user_id, :title, :short_title, :properties, :tags, :keywords, :description, :image_path, :content
  json.url admin_page_url(admin_page, format: :json)
end
