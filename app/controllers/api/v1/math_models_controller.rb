class Api::V1::MathModelsController < Api::V1::ApplicationController

	def show
		@math_model = MathModel.where(id: params[:id]).first
		render json: @math_model
	end

	def math_model_asset_version
		@math_model = MathModel.where(id: params[:id]).first
		render json: {
			versions: @math_model.math_model_assets.as_json({
				only: [:id, :version]
			}),
			active_math_model_version_id: @math_model.active_math_model_asset.try(:id)
		}
	end

end