class GameVersion < ActiveRecord::Base
	before_save :force_update_app

	private

	def force_update_app
		user = User.where(game_version: self.version)
		if user.present?
			user.update_all(update_required: self.require_update)
		end
	end

end
