class Api::V1::GamesController < ApplicationController

	def show
		@game = Game.where(id: params[:id]).first
		render json: @game.as_json({
			include: {
				slots: {
					only: [:name],
					methods: [:pay_line_coordinates, :reel_series],
					include: {
						pay_tables: {
							only: [:count, :points],
							methods: [:symbol]
						}
					}
				}
			}
		})
	end

end