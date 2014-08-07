class PayTable < ActiveRecord::Base

	belongs_to :stamp

	def symbol
		stamp.name
	end

end
