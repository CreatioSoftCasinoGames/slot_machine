class UtilityController < ApplicationController

	def show_api_key
		@api_key = ApiKey.where(active: true).first
	end

	def generate_api_key 
		ApiKey.create
		redirect_to show_api_key_url, flash: {success: "New keys created successfully !"}
	end

	def sync_data
		REDIS_CLIENT.SET("tournament_start", true)
		Machine.includes(:tournaments).all.each do |machine|
			REDIS_CLIENT.SADD("machines", "machine:#{machine.machine_number}")
			REDIS_CLIENT.HMSET("machine:#{machine.machine_number}", "id", machine.id,"name", machine.name, "machine_type", machine.machine_type, "min_players", machine.min_players, "max_players", machine.max_players, "machine_number", machine.machine_number)
			REDIS_CLIENT.SADD("machines_occupancy", "machine_id:#{machine.machine_number}")
			machine.tournaments.each do |tournament|
				REDIS_CLIENT.ZADD("tournament_sorted_set", tournament.min_entry_level, "players_tournament:#{tournament.id}")
				REDIS_CLIENT.HMSET("players_tournament:#{tournament.id}", "machine_name", machine.name, "machine_id", machine.machine_number, "machine_number", machine.id, "min_entry_level", tournament.min_entry_level, "max_entry_level", tournament.max_entry_level, "seed_money", tournament.seed_money, "timeout", tournament.time_out, "interval", tournament.interval, "points_required", tournament.points_required)
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