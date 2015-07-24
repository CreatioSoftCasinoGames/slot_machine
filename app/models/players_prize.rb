class PlayersPrize < ActiveRecord::Base
	after_save :sync_database

	private

	def sync_database
		REDIS_CLIENT.HMSET("in_game_data", "prize_pool_percent", prize_pool_percent, "next_winner_difference", next_winner_difference, "user_score_percent", user_score_percent, "player_one_percent", player_one_percent, "player_two_percent", player_two_percent, "player_three_percent", player_three_percent)
	end

end
