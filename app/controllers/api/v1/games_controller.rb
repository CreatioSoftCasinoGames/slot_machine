class Api::V1::GamesController < Api::V1::ApplicationController

	def index
		@games = Game.all
		render json: @games.as_json({
				only: [:name, :id]
			})
	end

	def show
		@game = Game.where(id: params[:id]).first
		render json: @game.as_json({
			include: {
				active_math_model: {
					only: [:name],
					methods: [:pay_line_coordinates, :reel_series],
					include: {
						pay_tables: {
							only: [:count, :points],
							methods: [:symbol]
						}
					}
				},
				active_asset: {
					only: [:label, :version, :is_permanent, :file_file_size, :file_updated_at, :country, :bundle_type],
					methods: [:url]
				}
			}
		})
	end

end