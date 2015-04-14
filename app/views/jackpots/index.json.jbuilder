json.array!(@jackpots) do |jackpot|
  json.extract! jackpot, :id, :jackpot_type, :seed_amount, :player_percent
  json.url jackpot_url(jackpot, format: :json)
end
