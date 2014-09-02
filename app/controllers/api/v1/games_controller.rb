class Api::V1::GamesController < Api::V1::ApplicationController

	def index
		@games = Game.all
		render json: @games
	end

	def show
		@game = Game.where(id: params[:id]).first
		render json: @game
	end

end