class UpdateProfileWorker
	include Sidekiq::Worker

	sidekiq_options retry: false

	def perform(data)
		profile_data = JSON.parse(data)
		user = User.find(profile_data["id"])
		if user.present?
			user.update_attributes(
				total_bet: 		profile_data["total_bet"],
				coins_won: 		profile_data["coins_won"],
				coins_lost: 	profile_data["coins_lost"],
				total_spin: 	profile_data["total_spin"]
			)
		end
	end

end

