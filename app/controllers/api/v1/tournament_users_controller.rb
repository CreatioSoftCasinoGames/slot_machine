class Api::V1::TournamentUsersController < Api::V1::ApplicationController
	before_action :find_tournament_user, only: [:update]
	def create
		@tournament_user.attributes = {user_id: User.fetch_by_login_token(params[:login_token])}
		@tournament_user = TournamentUser.new(tournament_user_params)
		if @tournament_user.save
			render json: {
				success: true
			}
		else
			render json: {
				success: false,
				errors: @tournament_user.errors.full_messages.join(", ")
			}
		end
	end

	def update
		if @tournament_user.update_attributes(tournament_user_params)
			render json: {
				success: true
			}
		else
			render json: {
				success: false,
				errors: @tournament_user.errors.full_messages.join(", ")
			}
		end
	end

	private

	def tournament_user_params
		params.require(:tournament_user).permit(:tournament_id, :rank, :point, :prize, :status)
	end

	def find_tournament_user
		@tournament_user = TournamentUser.where(id: params[:id]).first
		(render json: {message: "TournamentUser not found", success: false}) if @tournament_user.blank?
	end

end