class VersionsController < ApplicationController
	
	def index
		@versions = User.where(device: params[:device]).collect(&:game_version).uniq
	end

	def game_versions
		
	end

	def update_users
		@users = User.where(game_version: params[:version], device: params[:device])
		if @users.update_all(update_required: true)
			redirect_to :back, notice: "Successfully updated"
		else
			redirect_to :back, notice: @user.errors.full_messages.join(", ")
		end
	end

end