class Api::V1::MiniGamesController < Api::V1::ApplicationController

	def show
		@mini_game = MiniGame.where(id: params[:id]).first
		render json: @mini_game
	end

	def mini_game_asset_version
		@mini_game = MiniGame.where(id: params[:id]).first
		render json:{
			versions: @mini_game.assets.as_json({
				only: [:id, :version]
			}),
			active_asset_id: @mini_game.active_asset.try(:id)
		}
	end

end