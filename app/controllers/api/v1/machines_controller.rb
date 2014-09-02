class Api::V1::MachinesController < Api::V1::ApplicationController

	def math_model_versions
		@machine = Machine.where(id: params[:id]).first
		render json: {
			versions: @machine.math_models.as_json({
				only: [:id, :version]
			}),
			active_math_model_id: @machine.active_math_model.try(:id)
		}
	end

	def in_game_asset_versions
		@machine = Machine.where(id: params[:id]).first
		render json: {
			versions: @machine.in_game_assets.as_json({
				only: [:id, :version]
			}),
			active_in_game_asset_id: @machine.active_in_game_asset.try(:id)
		}
	end

	def out_game_asset_versions
		@machine = Machine.where(id: params[:id]).first
		render json: {
			versions: @machine.out_game_assets.as_json({
				only: [:id, :version]
			}),
			active_out_game_asset_id: @machine.active_out_game_asset.try(:id)
		}
	end

end