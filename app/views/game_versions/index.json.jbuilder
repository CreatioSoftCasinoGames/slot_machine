json.array!(@game_versions) do |game_version|
  json.extract! game_version, :id, :version, :require_update
  json.url game_version_url(game_version, format: :json)
end
