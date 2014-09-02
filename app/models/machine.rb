class Machine < ActiveRecord::Base

	has_many :math_models
	has_many :in_game_assets, -> { where(assets: {bundle_type: ASSET_BUNDLE_TYPE[:IN_GAME_ASSET]}) }, as: :resource, class_name: "Asset"
	has_many :out_game_assets, -> { where(assets: {bundle_type: ASSET_BUNDLE_TYPE[:IN_GAME_ASSET]}) }, as: :resource, class_name: "Asset"
	has_many :mini_games
	belongs_to :theme

end
