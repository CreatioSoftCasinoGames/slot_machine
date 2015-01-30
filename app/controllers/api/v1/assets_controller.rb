class Api::V1::AssetsController < Api::V1::ApplicationController

	def show
		@asset = Asset.where(id: params[:id]).first
		render json: @asset
	end

  def machine_assets
    @machine = Machine.where(machine_number: params[:id]).first
    @active_assets = @machine.active_asset.where(country: params[:country])
    @check_math = @machine.active_asset.where(bundle_type: "MATH_MODEL_ASSET", country: params[:country])
    @check_mini = @machine.active_asset.where(bundle_type: "MINI_GAME_ASSET", country: params[:country])
    @check_graphic = @machine.active_asset.where(bundle_type: "GRAPHIC_ASSET", country: params[:country])
    if @check_math.blank?
        if @active_assets.present?
            @active_assets = @active_assets + @machine.active_asset.where(bundle_type: "MATH_MODEL_ASSET", country: "World_Wide")
        else
            @active_assets = @machine.active_asset.where(bundle_type: "MATH_MODEL_ASSET", country: "World_Wide")
        end
    end
    if @check_mini.blank?
        if @active_assets.present?
            @active_assets = @active_assets + @machine.active_asset.where(bundle_type: "MINI_GAME_ASSET", country: "World_Wide")
        else
            @active_assets = @machine.active_asset.where(bundle_type: "MINI_GAME_ASSET", country: "World_Wide")
        end
    end
    if @check_graphic.blank?
        if @imp_math_model.present?
            @active_assets = @active_assets + @machine.active_asset.where(bundle_type: "GRAPHIC_ASSET", country: "World_Wide")
        else
            @active_assets = @machine.active_asset.where(bundle_type: "GRAPHIC_ASSET", country: "World_Wide")
        end
    end
     respond_to do |format|
        if @active_assets.present?
            format.json{render json: @active_assets }
        end
    end

  end

end