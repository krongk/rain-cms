json.array!(@admin_forages) do |admin_forage|
  json.extract! admin_forage, :id, :title, :content, :tag, :author, :original_url
  json.url admin_forage_url(admin_forage, format: :json)
end
