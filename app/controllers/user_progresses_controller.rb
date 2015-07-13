class UserProgressesController < ApplicationController

	def index
		@versions = User.where(unique_id: params[:unique_id]).first.try(:versions)
	end

end