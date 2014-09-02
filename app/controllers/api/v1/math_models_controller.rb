class Api::V1::MathModelsController < Api::V1::ApplicationController

	def show
		@math_model = MathModel.where(id: params[:id]).first
		render json: @math_model
	end

end