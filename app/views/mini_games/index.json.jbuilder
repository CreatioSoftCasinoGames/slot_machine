json.array!(@mini_games) do |mini_game|
  json.extract! mini_game, :id, :name, :description, :machine_id
  json.url mini_game_url(mini_game, format: :json)
end
