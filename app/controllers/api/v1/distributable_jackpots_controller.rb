class Api::V1::DistributableJackpotsController < Api::V1::ApplicationController

	def index
		render json: DistributableJackpot.where(active: true)
	end

	def jackpot_amount
		@distributable_jackpot = DistributableJackpot.where(id: params[:id]).first
		if @distributable_jackpot.update_attributes(jackpot_amount: params[:amount])
			render json: @distributable_jackpot.as_json({
				only: [:amount]
			})
		else
			@distributable_jackpot.errors.full_messages.join(", ")
		end
	end

end