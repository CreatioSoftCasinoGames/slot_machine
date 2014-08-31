class Api::V1::WelcomeController < Api::V1::ApplicationController

	def index
		render json: {success: true}
	end

	def versions
		@game = Game.where(name: params[:resource]).first
		if(params[:entity] == "math_model")
			render json: {
				versions: @game.math_models.collect { |math_model| {version: math_model.version, math_model_id: math_model.id} },
				active_math_model_id: @game.active_math_model.id
			}
		else
			render json: {
				versions: @game.assets.collect { |asset| {version: asset.version, asset_id: asset.id} },
				active_asset_id: @game.active_asset.id
			}
		end
	end

end