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
			REDIS_CLIENT.HMSET("machine:#{machine.id}", "name", machine.name, "machine_type", machine.machine_type, "min_players", machine.min_players, "max_players", machine
				.max_players, "machine_number", machine.machine_number)
			machine.tournaments.each do |tournament|
				REDIS_CLIENT.ZADD("tournament_sorted_set", tournament.max_entry_level, "players_tournamnet:#{tournamnet.max_entry_level}")
				REDIS_CLIENT.set("players_tournamnet:#{tournament.max_entry_level}", tournament.id)
			end
		end
		redirect_to root_path, flash: {success: "Data successfully synced !"}
	end

end