class Api::V1::GamesController < Api::V1::ApplicationController

	def index
		@games = Game.all
		render json: @games
	end

	def show
		@game = Game.where(id: params[:id]).first
		render json: @game
	end

	def game_asset_version
		@game = Game.where(id: params[:id]).first
		render json: {
			versions: @game.game_assets.as_json({
				only: [:id, :version]
			}),
			active_game_asset_version_id: @game.active_game_asset.try(:id)
		}
	end

end