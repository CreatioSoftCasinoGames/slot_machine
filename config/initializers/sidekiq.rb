# Sidekiq.configure_server do |config|
#   config.redis = { url: 'redis://localhost:6379/' }
# end

# Sidekiq.configure_client do |config|
#   config.redis = { url: 'redis://localhost:6379/' }
# end

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://sidekiq.qlo4xg.0001.usw2.cache.amazonaws.com:6379/' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://sidekiq.qlo4xg.0001.usw2.cache.amazonaws.com:6379/' }
end