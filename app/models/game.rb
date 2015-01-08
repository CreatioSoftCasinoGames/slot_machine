class Game < ActiveRecord::Base

	has_many :machines
	has_many :assets, as: :resource
	has_many :game_assets, -> {where(assets: {bundle_type: ASSET_BUNDLE_TYPE[:GAME_ASSET]})}, as: :resource, class_name: "Asset"
	has_many :active_game_asset, -> {where(assets: {bundle_type: ASSET_BUNDLE_TYPE[:GAME_ASSET], active: true})}, as: :resource, class_name: "Asset"

	# has_one :active_math_model, -> { where(math_models: {active: true}) }, class_name: MathModel
	# has_one :active_asset, -> { where(assets: {active: true}) }, class_name: Asset

	def as_json(options={})
    super({
      only: [:name]
    }.merge(options))
  end

end
