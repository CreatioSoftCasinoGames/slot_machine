class PlayersPrizeSerializer < ActiveModel::Serializer
  attributes :id, :prize_pool_percent, :next_winner_difference, :user_score_percent, :player_one_percent, :player_two_percent, :player_three_percent
end
