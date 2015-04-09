class Machine < ActiveRecord::Base

	has_many :assets, as: :resource
	has_many :active_asset, -> { where(assets: {active: true}) }, as: :resource, class_name: "Asset"
	has_many :tournaments, :dependent => :destroy
	
end
