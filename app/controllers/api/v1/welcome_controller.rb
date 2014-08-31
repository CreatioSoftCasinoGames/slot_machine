class Api::V1::WelcomeController < Api::V1::ApplicationController

	def index
		render json: {success: true}
	end

end