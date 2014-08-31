class Api::V1::GamesController < Api::V1::ApplicationController

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
						},
						assets: {
							only: [:label, :version, :is_permanent, :file_file_size, :file_updated_at, :country, :bundle_type],
							methods: [:url]
						}
					}
				}
			}
		})
	end

end