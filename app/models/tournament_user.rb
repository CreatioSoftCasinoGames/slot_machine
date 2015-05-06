class TournamentUser < ActiveRecord::Base
	belongs_to :user
	belongs_to :tournament

	def machine_id
		self.tournament.machine.id
	end

end
