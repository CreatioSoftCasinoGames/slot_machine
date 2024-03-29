class UserSerializer < ActiveModel::Serializer

  attributes :id, 
  					 :login_token,
  					 :previous_login_token, 
  					 :first_name, 
  					 :last_name, 
  					 :email, 
  					 :country, 
  					 :stars,
             :total_coins,
  					 :best_position_in_tournament, 
  					 :num_of_tournament_participated, 
  					 :biggest_tournament_win_amount, 
  					 :machine_unlocked, 
  					 :current_level, 
  					 :image_url,
  					 :player_since,
             :is_fb_connected,
             :device_changed,
             :first_fb_sync,
             :version,
             :total_iap_made,
             :gift_count,
             :device_id,
             :update_required,
             :bet_index,
             :bet_per_line,
             :unique_id
      has_one :celebration
  
end
