class Theme < ActiveRecord::Base

	belongs_to :game
	has_many :machines
	has_many :assets, as: :resource
	has_one :active_asset, -> { where(assets: {active: true}) }, as: :resource, class_name: "Asset"

end
