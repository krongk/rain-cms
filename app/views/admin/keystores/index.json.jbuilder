json.array!(@admin_keystores) do |admin_keystore|
  json.extract! admin_keystore, :name, :value
  json.url admin_keystore_url(admin_keystore, format: :json)
end
