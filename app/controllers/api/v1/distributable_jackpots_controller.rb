class Api::V1::DistributableJackpotsController < Api::V1::ApplicationController

	def index
		render json: DistributableJackpot.where(active: true)
	end

end