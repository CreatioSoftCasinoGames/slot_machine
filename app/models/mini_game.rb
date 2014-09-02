class MiniGame < ActiveRecord::Base

	has_many :assets, as: :resource
	has_one :active_asset, -> { where(assets: {active: true}) }, as: :resource, class_name: "Asset"
	belongs_to :machine

end
