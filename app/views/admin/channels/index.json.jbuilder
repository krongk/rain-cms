json.array!(@admin_channels) do |admin_channel|
  json.extract! admin_channel, :user_id, :typo, :title, :properties, :default_url, :tmp_index, :tmp_list, :tmp_detial, :keywords, :description, :content
  json.url admin_channel_url(admin_channel, format: :json)
end
