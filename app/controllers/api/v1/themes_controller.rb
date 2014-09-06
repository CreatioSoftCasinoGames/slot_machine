class Api::V1::ThemesController < Api::V1::ApplicationController

	def asset_versions
		@theme = Theme.where(id: params[:id]).first
		render json: {
			versions: @theme.assets.as_json({
				only: [:id, :version]
			}),
			active_version_id: @theme.active_asset.try(:id)
		}
	end

	def show
		@theme = Theme.where(id: params[:id]).first
		render json: @theme
	end

end