class Api::V1::GamesController < Api::V1::ApplicationController
	before_action :find_game, only: [:show, :asset_versions]

	def index
		@games = Game.all
		render json: @games
	end

	def show
		render json: @game
	end

	def asset_versions
		render json: {
			versions: @game.assets.as_json({
				only: [:id, :version]
			}),
			active_game_asset_version_id: @game.active_asset.try(:id)
		}
	end

	private

	def find_game
		@game = Game.where(id: params[:id]).first
	end

end