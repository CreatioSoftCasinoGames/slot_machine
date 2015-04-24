class UtilityController < ApplicationController

	def show_api_key
		@api_key = ApiKey.where(active: true).first
	end

	def generate_api_key 
		ApiKey.create
		redirect_to show_api_key_url, flash: {success: "New keys created successfully !"}
	end

	def sync_data
		Machine.includes(:tournaments).all.each do |machine|
			REDIS_CLIENT.SADD("machines", "machine:#{machine.id}")
			REDIS_CLIENT.HMSET("machine:#{machine.id}", "name", machine.name, "machine_type", machine.machine_type, "min_players", machine.min_players, "max_players", machine.max_players, "machine_number", machine.machine_number)
			REDIS_CLIENT.SADD("machines_occupancy", "machine_id:#{machine.id}")
			machine.tournaments.each do |tournament|
				REDIS_CLIENT.ZADD("tournament_sorted_set", tournament.min_entry_level, "players_tournamnet:#{tournament.id}")
				REDIS_CLIENT.HMSET("players_tournamnet:#{tournament.id}", "min_entry_level", tournament.min_entry_level, "max_entry_level", tournament.max_entry_level, "seed_money", tournament.seed_money, "timeout", tournament.time_out, "interval", tournament.interval, "points_required", tournament.points_required)
			end
		end
		redirect_to root_path, flash: {success: "Data successfully synced !"}
	end

end