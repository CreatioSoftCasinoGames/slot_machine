class DistributableJackpot < ActiveRecord::Base
	belongs_to :jackpot
	before_create :set_default_fields
	before_update :increase_jackpot_amount
	attr_accessor :jackpot_amount

	def jackpot_type
		jackpot.jackpot_type
	end

	def self.mark_as_distributed
		distributable_jackpots = DistributableJackpot.where(active: true)
		if distributable_jackpots.present?
			distributable_jackpots.each do |distributable_jackpot|
				if distributable_jackpot.jackpot.jackpot_type == "Mini"
					distributable_jackpot.update_attributes(winner_id: 1, active: false)
					DistributableJackpot.create(jackpot_id: distributable_jackpot.jackpot.id, seed_amount: distributable_jackpot.seed_amount, amount: distributable_jackpot.seed_amount)
				elsif distributable_jackpot.created_at.to_date == (Time.now - 1.days).to_date
					distributable_jackpot.update_attributes(winner_id: 1, active: false)
					DistributableJackpot.create(jackpot_id: distributable_jackpot.jackpot.id, seed_amount: distributable_jackpot.seed_amount, amount: distributable_jackpot.seed_amount)
				end
			end
		else
			mini_jackpot = Jackpot.where(jackpot_type: "Mini").first
			major_jackpot = Jackpot.where(jackpot_type: "Major").first
			DistributableJackpot.create(jackpot_id: mini_jackpot.id, amount: mini_jackpot.seed_amount)
			DistributableJackpot.create(jackpot_id: major_jackpot.id, amount: major_jackpot.seed_amount)
		end
	end

	private

	def set_default_fields
		self.seed_amount = jackpot.seed_amount
		self.player_percentage = jackpot.player_percent
	end

	def increase_jackpot_amount
		if jackpot_amount
			self.amount = amount + jackpot_amount.to_f
		end
	end

end
