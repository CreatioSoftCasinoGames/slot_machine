class Api::V1::AssetsController < Api::V1::ApplicationController

	def show
		@asset = Asset.where(id: params[:id]).first
		render json: @asset
	end

end