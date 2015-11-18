class UpdateProfileWorker
	include Sidekiq::Worker

	sidekiq_options retry: false

	def perform(data)
		profile_data = JSON.parse(data)
		user = User.where(id: profile_data["id"].to_i).first
		if user.present?
			if profile_data["update_from"] == "Server"
				user.update_attributes(
					total_bet: 		profile_data["total_bet"],
					coins_won: 		profile_data["coins_won"],
					coins_lost: 	profile_data["coins_lost"],
					total_spin: 	profile_data["total_spin"]
				)
			else
				user.update_attributes(
					stars: 						profile_data["stars"],
					bet_index: 				profile_data["bet_index"],
					total_coins: 			profile_data["total_coins"],
					bet_per_line: 		profile_data["bet_per_line"],
					current_level: 		profile_data["current_level"],
					machine_unlocked: profile_data["machine_unlocked"]
				)

				celebration = Celebration.where(user_id: profile_data["id"].to_i).first
				if celebration.present?
					celebration.update_attributes(celebrations: profile_data["celebrations"] , reward: profile_data["reward"])
				else
					Celebration.create(celebrations: profile_data["celebrations"] , reward: profile_data["reward"], user_id: profile_data["id"].to_i)
				end

			end
		end
	end

end

