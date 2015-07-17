json.array!(@players_prizes) do |players_prize|
  json.extract! players_prize, :id, :prize_pool_percent, :next_winner_difference, :user_score_percent, :player_one_percent, :player_two_percent, :player_three_percent
  json.url players_prize_url(players_prize, format: :json)
end
