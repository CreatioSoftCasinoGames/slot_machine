class Api::V1::WelcomeController < ApplicationController

	def index
		render json: {success: true}
	end

end