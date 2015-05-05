class Api::V1::DistributableJackpotsController < Api::V1::ApplicationController

	def index
		render json: DistributableJackpot.where(is_distributed: false)
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

	def winner_jackpot
		@user = User.fetch_by_login_token(params[:login_token])
		render json: Jackpot.where(jackpot_type: params[:type]).first.distributable_jackpots.where(winner_id: @user.id).as_json({
			only: [:amount]
		})
	end

end