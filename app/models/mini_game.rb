class MiniGame < ActiveRecord::Base

	has_many :assets, as: :resource
	belongs_to :machine

end
