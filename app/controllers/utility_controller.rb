class UtilityController < ApplicationController

	def show_api_key
		@api_key = ApiKey.where(active: true).first
	end

	def generate_api_key 
		ApiKey.create
		redirect_to show_api_key_url, flash: {success: "New keys created successfully !"}
	end

	def sync_users_profile
		User.order("id asc").each do |user|
			REDIS_CLIENT.SADD("user_profiles:1-1000", "user_profile:#{user.id}")
			REDIS_CLIENT.HMSET("user_profile:#{user.id}", "id", user.id, "total_coins", user.total_coins, "stars", user.stars, 
																										"total_coins", user.total_coins, "bet_index",  user.bet_index, 
																										"bet_per_line", user.bet_per_line, "current_level", user.current_level, 
																										"total_bet", user.total_bet, "coins_won", user.coins_won, "coins_lost", user.coins_lost, 
																										"total_spin", user.total_spin, "online", false)
		end
		redirect_to root_path, flash: {success: "User profile has been synched successfully !"}
	end

	def sync_data
		@min_jackpot = Jackpot.where(jackpot_type: "Min").first.distributable_jackpots.where(is_distributed: false).last
		@major_jackpot = Jackpot.where(jackpot_type: "Major").first.distributable_jackpots.where(is_distributed: false).last
		REDIS_CLIENT.HMSET("jackpot_details", "min_id", @min_jackpot.id, "min_amount", @min_jackpot.amount, "major_id", @major_jackpot.id, "major_amount", @major_jackpot.amount)
		REDIS_CLIENT.SET("tournament_start", true)
		Machine.includes(:tournaments).all.each do |machine|
			REDIS_CLIENT.SADD("machines", "machine:#{machine.machine_number}")
			REDIS_CLIENT.HMSET("machine:#{machine.machine_number}", "id", machine.id,"name", machine.name, "machine_type", machine.machine_type, "min_players", machine.min_players, "max_players", machine.max_players, "machine_number", machine.machine_number)
			REDIS_CLIENT.SADD("machines_occupancy", "machine_id:#{machine.machine_number}")
			machine.tournaments.each do |tournament|
				REDIS_CLIENT.ZADD("tournament_sorted_set:#{machine.machine_number}", tournament.min_entry_level, "players_tournament:#{tournament.id}")
				REDIS_CLIENT.HMSET("players_tournament:#{tournament.id}", "machine_name", machine.name, "machine_id", machine.machine_number, "machine_number", machine.id, "min_entry_level", tournament.min_entry_level, "max_entry_level", tournament.max_entry_level, "seed_money", tournament.seed_money, "timeout", tournament.time_out, "interval", tournament.interval, "points_required", tournament.points_required)
			end
		end

		PlayersPrize.all.each do |player_prize|
			REDIS_CLIENT.HMSET("in_game_data", "prize_pool_percent", player_prize.prize_pool_percent, "next_winner_difference", player_prize.next_winner_difference, "user_score_percent", player_prize.user_score_percent, "player_one_percent", player_prize.player_one_percent, "player_two_percent", player_prize.player_two_percent, "player_three_percent", player_prize.player_three_percent)
		end

		Jackpot.all.each do |jackpot|
			if(jackpot.jackpot_type == "Min")
				REDIS_CLIENT.SET("player_precent_min", jackpot.player_percent)
			else
				REDIS_CLIENT.SET("player_precent_major", jackpot.player_percent)
			end
		end

		DistributableJackpot.where(active: true).each do |jackpot|
			if(jackpot.jackpot.jackpot_type == "Min")
				REDIS_CLIENT.SET("min_jackpot", jackpot.amount)
			else
				REDIS_CLIENT.SET("major_jackpot", jackpot.amount)
			end
		end

		redirect_to root_path, flash: {success: "Complete database has been successfully synced !"}
	end

	def sync_tournament

		REDIS_CLIENT.DEL("tournament_sorted_set")
		Machine.includes(:tournaments).all.each do |machine|
			machine.tournaments.each do |tournament|
				REDIS_CLIENT.DEL("players_tournament:#{tournament.id}")
			end
		end

		Machine.includes(:tournaments).all.each do |machine|
			machine.tournaments.each do |tournament|
				REDIS_CLIENT.ZADD("tournament_sorted_set", tournament.min_entry_level, "players_tournament:#{tournament.id}")
				REDIS_CLIENT.HMSET("players_tournament:#{tournament.id}", "machine_name", machine.name, "machine_id", machine.machine_number, "machine_number", machine.id, "min_entry_level", tournament.min_entry_level, "max_entry_level", tournament.max_entry_level, "seed_money", tournament.seed_money, "timeout", tournament.time_out, "interval", tournament.interval, "points_required", tournament.points_required)
			end
		end
		redirect_to root_path, flash: {success: "Tournament data has been successfully synced !"}
	end

	def stop_tournament
		REDIS_CLIENT.SET("tournament_start", false)
		redirect_to root_path, flash: {success: "No new tournament will start!"}
	end

	def start_tournament
		REDIS_CLIENT.SET("tournament_start", true)
		redirect_to root_path, flash: {success: "Tournament will start normally!"}
	end

	def delete_data
		REDIS_CLIENT.FLUSHALL
		redirect_to root_path, flash: {success: "Data successfully deleted, Please Sync to proceed!"}
	end

end