class Api::V1::AssetsController < Api::V1::ApplicationController

	def show
		@asset = Asset.where(id: params[:id]).first
		render json: @asset
	end

  def machine_assets
    @machine = Machine.where(machine_number: params[:id]).first
    @assets = @machine.assets
    @active_assets = @machine.active_asset
    if params[:bundle_type] == ASSET_BUNDLE_TYPE[:MATH_MODEL_ASSET]
    	@main_game_asset = @assets.where(bundle_type: params[:bundle_type])
        @active_asset = @main_game_asset.where(active: true)
    	render json: {
    		versions: @main_game_asset.as_json({
    			only: [:id, :version]
    		}),
    		active_asset: @active_asset.as_json({
                only: [:id]
            })
    	}
    end
   	if params[:bundle_type] == ASSET_BUNDLE_TYPE[:MINI_GAME_ASSET]
    	@mini_game_asset = @assets.where(bundle_type: params[:bundle_type])
        @active_asset = @mini_game_asset.where(active: true)
    	render json: {
    		versions: @mini_game_asset.as_json({
    			only: [:id, :version]
    		}),
    		active_asset: @active_asset.as_json({
                only: [:id]
            })
    	}
    end
    if params[:bundle_type] == ASSET_BUNDLE_TYPE[:GRAPHIC_ASSET]
    	@graphic_asset = @assets.where(bundle_type: params[:bundle_type])
        @active_asset = @graphic_asset.where(active: true)
    	render json: {
    		versions: @graphic_asset.as_json({
    			only: [:id, :version]
    		}),
    		active_asset: @active_asset.as_json({
                only: [:id]
            })
    	}
    end
  end

end