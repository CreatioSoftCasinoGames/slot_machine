class UserSerializer < ActiveModel::Serializer

  attributes :id, 
  					 :login_token,
  					 :previous_login_token, 
  					 :first_name, 
  					 :last_name, 
  					 :email, 
  					 :fb_id, 
  					 :country, 
  					 :stars, 
  					 :diamonds, 
  					 :fb_id, 
  					 :device_id, 
  					 :total_spin, 
  					 :best_position_in_tournament, 
  					 :num_of_tournament_participated, 
  					 :biggest_tournament_win_amount, 
  					 :machine_unlocked, 
  					 :current_level, 
  					 :image_url,
  					 :player_since,
             :is_fb_connected,
             :mini_jackpot_status,
             :major_jackpot_status
             :version
      has_one :celebration
  
end
