json.array!(@tournaments) do |tournament|
  json.extract! tournament, :id, :min_player, :max_player, :min_entry_level, :max_entry_level, :seed_money, :time_out
  json.url tournament_url(tournament, format: :json)
end
