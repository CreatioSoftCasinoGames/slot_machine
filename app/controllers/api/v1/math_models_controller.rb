class Api::V1::MathModelsController < Api::V1::ApplicationController

	def show
		@math_model = MathModel.where(id: params[:id]).first
		render json: @math_model.as_json({
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
		@math_model = MathModel.where(id: params[:id]).first
	end

end