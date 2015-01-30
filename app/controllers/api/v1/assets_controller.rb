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
        @imp_math_model = @machine.active_asset.where(bundle_type: "MATH_MODEL_ASSET", country: "World_Wide")
    end
    if @check_mini.blank?
        @imp_mini_model = @machine.active_asset.where(bundle_type: "MINI_GAME_ASSET", country: "World_Wide")
    end
    if @check_graphic.blank?
        @imp_graphic_model = @machine.active_asset.where(bundle_type: "GRAPHIC_ASSET", country: "World_Wide")
    end
    render json: {
        assets: @active_assets.as_json({
            only: [:version, :bundle_type, :file_file_size],
            methods: [:url, :file_updated_at]
        }),
        world_wide_math_assets: @imp_math_model.as_json({
            only: [:version, :bundle_type, :file_file_size],
            methods: [:url, :file_updated_at]
        }),
        world_wide_mini_game_assets: @imp_mini_model.as_json({
            only: [:version, :bundle_type, :file_file_size],
            methods: [:url, :file_updated_at]
        }),
        world_wide_graphic_assets: @imp_graphic_model.as_json({
            only: [:version, :bundle_type, :file_file_size],
            methods: [:url, :file_updated_at]
        })
    }

  end

end