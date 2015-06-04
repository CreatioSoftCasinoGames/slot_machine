class Api::V1::DistributableJackpotsController < Api::V1::ApplicationController

	def index
		@min_jackpot = Jackpot.where(jackpot_type: "Min").first.distributable_jackpots.where(is_distributed: false).last
		@major_jackpot = Jackpot.where(jackpot_type: "Major").first.distributable_jackpots.where(is_distributed: false).last
		render json: {
			min_id: @min_jackpot.id,
			major_id: @major_jackpot.id,
			min: @min_jackpot.amount,
			major: @major_jackpot.amount
		}
	end

	def update
		@distributable_jackpot = DistributableJackpot.where(id: params[:id]).first
		if @distributable_jackpot.update_attributes(is_distributed: true)
			render json:{
				success: true
			}
		else
			render json:{
				success: false,
				error: @distributable_jackpot.errors.full_messages.join(", ")
			}
		end
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