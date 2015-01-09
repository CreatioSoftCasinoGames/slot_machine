class Api::V1::MathModelsController < Api::V1::ApplicationController
	before_action :find_math_model, only: [:show, :asset_versions]

	def show
		render json: @math_model
	end

	def asset_versions
		render json: {
			versions: @math_model.assets.as_json({
				only: [:id, :version]
			}),
			active_math_model_version_id: @math_model.active_asset.try(:id)
		}
	end

	private

	def find_math_model
		@math_model = MathModel.where(id: params[:id]).first
	end

end