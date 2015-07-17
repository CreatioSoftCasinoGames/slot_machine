class Jackpot < ActiveRecord::Base
	has_many :distributable_jackpots, :dependent => :destroy
	after_save :sync_player_precent

	private

	def sync_player_precent
		Jackpot.all.each do |jackpot|
			p jackpot
			REDIS_CLIENT.SET("player_precent_"+jackpot.jackpot_type.downcase, jackpot.player_percent)
		end
	end

end
