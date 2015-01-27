class Machine < ActiveRecord::Base

	has_many :assets, -> { where(assets: {bundle_type: ASSET_BUNDLE_TYPE[:MACHINE_ASSET]}) }, as: :resource, class_name: "Asset"
  has_one :active_asset, -> { where(assets: {bundle_type: ASSET_BUNDLE_TYPE[:MACHINE_ASSET],  active: true}) }, as: :resource, class_name: "Asset"
	#has_one :active_math_model, -> { where(math_models: {active: true}) }, class_name: "MathModel"

	has_many :assets, as: :resource
	has_one :active_asset, -> { where(assets: {active: true}) }, as: :resource, class_name: "Asset"
	
end
