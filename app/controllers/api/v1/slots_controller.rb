class Api::V1::SlotsController < Api::V1::ApplicationController

	def show
		@slot = Slot.where(id: params[:id]).first
		render json: @slot.as_json({
			only: [:name],
			methods: [:pay_line_coordinates, :reel_series],
			include: {
				pay_tables: {
					only: [:count, :points],
					methods: [:symbol]
				},
				active_asset: {
					only: [:label, :version, :is_permanent, :file_file_size, :file_updated_at, :country, :bundle_type],
					methods: [:url]
				}
			}
		})
	end

	def assets
		@slot = Slot.where(id: params[:id]).first
	end

end