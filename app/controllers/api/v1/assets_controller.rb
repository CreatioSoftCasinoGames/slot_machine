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
    if @check_math.blank?
        @imp_mini_model = @machine.active_asset.where(bundle_type: "MINI_GAME_ASSET", country: "World_Wide")
    end
    if @check_math.blank?
        @imp_graphic_model = @machine.active_asset.where(bundle_type: "GRAPHIC_ASSET", country: "World_Wide")
    end
    render json: {
        assets: @active_assets.as_json({
            only: [:version, :bundle_type, :file_file_size, :file_updated_at],
            methods: [:url]
        }),
        world_wide_assets: ({
            math_model: @imp_math_model,
            mini_game_model: @imp_mini_model,
            grahic_model: @imp_graphic_model
        })
    }
  end

end