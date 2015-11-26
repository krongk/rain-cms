Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379/2', namespace: "sidekiq.#{ENV['DOMAIN_NAME']}.#{Rails.env}" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379/2', namespace: "sidekiq.#{ENV['DOMAIN_NAME']}.#{Rails.env}" }
end