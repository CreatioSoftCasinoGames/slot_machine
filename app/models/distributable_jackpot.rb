class DistributableJackpot < ActiveRecord::Base
	belongs_to :jackpot
	before_create :set_default_fields

	def jackpot_type
		jackpot.jackpot_type
	end

	private

	def set_default_fields
		self.seed_amount = jackpot.seed_amount
		self.player_percentage = jackpot.player_percent
	end

end
