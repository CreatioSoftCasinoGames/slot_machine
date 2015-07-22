class JackpotsWorker
	require Sidekiq::Worker

	sidekiq_options retry: false

	def perform(data)
		jackpot_data = JSON.parse(data)
		Jackpot.where(jackpot_type: "Min").first.distributable_jackpots.where(active: true).last.update_attributes(amount: jackpot_data.min_amount)
		Jackpot.where(jackpot_type: "Major").first.distributable_jackpots.where(active: true).last.update_attributes(amount: jackpot_data.major_amount)
	end

end