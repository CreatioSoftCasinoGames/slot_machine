class DistributableJackpot < ActiveRecord::Base
	belongs_to :jackpot
	before_create :set_default_fields
	before_update :increase_jackpot_amount
	attr_accessor :jackpot_amount

	def jackpot_type
		jackpot.jackpot_type
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
