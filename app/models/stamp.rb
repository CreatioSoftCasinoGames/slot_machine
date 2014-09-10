class Stamp < ActiveRecord::Base

	belongs_to :math_model

	after_destroy :delete_pay_tables

	private

	def delete_pay_tables
		math_model.pay_tables.where(pay_tables: {stamp_id: self.id}).destroy_all
	end

end
