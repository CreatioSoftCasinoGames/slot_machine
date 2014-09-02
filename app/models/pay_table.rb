class PayTable < ActiveRecord::Base

	belongs_to :stamp
	belongs_to :math_model

	def symbol
		stamp.name
	end

end
