class TournamentUser < ActiveRecord::Base
	belongs_to :user
	belongs_to :tournament

	def machine_id
		self.tournament.try(:machine_id)
	end

	def machine_name
		self.tournament.try(:machine).try(:name)
	end

end
