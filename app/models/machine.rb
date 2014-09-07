class Machine < ActiveRecord::Base

	has_many :math_models
	has_one :active_math_model, -> { where(math_models: {active: true}) }, class_name: "MathModel"

	has_many :assets, as: :resource

	has_many :in_game_assets, -> { where(assets: {bundle_type: ASSET_BUNDLE_TYPE[:IN_GAME_ASSET]}) }, as: :resource, class_name: "Asset"
	has_one :active_in_game_asset, -> { where(assets: {bundle_type: ASSET_BUNDLE_TYPE[:IN_GAME_ASSET], active: true}) }, as: :resource, class_name: "Asset"

	has_many :out_game_assets, -> { where(assets: {bundle_type: ASSET_BUNDLE_TYPE[:OUT_GAME_ASSET]}) }, as: :resource, class_name: "Asset"
	has_one :active_out_game_asset, -> { where(assets: {bundle_type: ASSET_BUNDLE_TYPE[:OUT_GAME_ASSET], active: true}) }, as: :resource, class_name: "Asset"

	has_many :mini_games

	belongs_to :theme

end
