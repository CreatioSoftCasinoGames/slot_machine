class JackpotsWorker
	include Sidekiq::Worker

	sidekiq_options retry: false

	def perform(data)
		jackpot_data = JSON.parse(data)
		previous_min_jackpot = Jackpot.where(jackpot_type: "Min").first.distributable_jackpots.where(active: true).last.amount
		previous_major_jackpot = Jackpot.where(jackpot_type: "Major").first.distributable_jackpots.where(active: true).last.amount
		Jackpot.where(jackpot_type: "Min").first.distributable_jackpots.where(active: true).last.update_attributes(amount: previous_min_jackpot + jackpot_data["min_amount"])
		Jackpot.where(jackpot_type: "Major").first.distributable_jackpots.where(active: true).last.update_attributes(amount: previous_major_jackpot + jackpot_data["major_amount"])
	end

end