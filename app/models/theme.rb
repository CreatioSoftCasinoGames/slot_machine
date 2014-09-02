class Theme < ActiveRecord::Base

	belongs_to :game
	has_many :machines
	has_many :assets, as: :resource

end
