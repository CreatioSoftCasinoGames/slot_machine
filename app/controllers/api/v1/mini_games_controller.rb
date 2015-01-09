class Api::V1::MiniGamesController < Api::V1::ApplicationController
	before_action :find_mini_game, only: [:show, :asset_versions]
	def show
		render json: @mini_game
	end

	def asset_versions
		render json:{
			versions: @mini_game.assets.as_json({
				only: [:id, :version]
			}),
			active_asset_id: @mini_game.active_asset.try(:id)
		}
	end

	private

	def find_mini_game
		@mini_game = MiniGame.where(id: params[:id]).first
	end

end