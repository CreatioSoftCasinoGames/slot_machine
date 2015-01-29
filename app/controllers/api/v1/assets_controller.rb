class Api::V1::AssetsController < Api::V1::ApplicationController

	def show
		@asset = Asset.where(id: params[:id]).first
		render json: @asset
	end

  def machine_assets
    @machine = Machine.where(machine_number: params[:id]).first
    @assets = @machine.assets
    @active_assets = @machine.active_asset
    render json: {
        versions: @assets.as_json({
    		only: [:id, :version, :bundle_type, :country]
    	}),
    	active_asset: @active_assets.as_json({
            only: [:id, :bundle_type, :country]
        })
    }
  end

end