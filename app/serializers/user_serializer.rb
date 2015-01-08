class UserSerializer < ActiveModel::Serializer

  attributes :id, :first_name, :last_name, :email, :country, :stars, :diamonds, :fb_id, :total_bet, :coins_won, :coins_lost, :device_id, :total_spin, :best_position_in_tournament, :num_of_tournament_participated, :biggest_tournament_win_amount, :machine_unlocked, :current_level
  
end
