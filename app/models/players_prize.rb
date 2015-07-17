class PlayersPrize < ActiveRecord::Base
	after_save :sync_database

	private

	def sync_database
		REDIS_CLIENT.SET("prize_pool_percent", prize_pool_percent)
		REDIS_CLIENT.SET("next_winner_difference", next_winner_difference)
		REDIS_CLIENT.SET("user_score_percent", user_score_percent)
		REDIS_CLIENT.SET("player_one_percent", player_one_percent)
		REDIS_CLIENT.SET("player_two_percent", player_two_percent)
		REDIS_CLIENT.SET("player_three_percent", player_three_percent)
	end

end
