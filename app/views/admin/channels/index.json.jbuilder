json.array!(@admin_channels) do |admin_channel|
  json.extract! admin_channel, :user_id, :cate_type, :title, :properties, :default_index, :tmp_index, :tmp_list, :tmp_detial, :keywords, :description, :content
  json.url admin_channel_url(admin_channel, format: :json)
end
