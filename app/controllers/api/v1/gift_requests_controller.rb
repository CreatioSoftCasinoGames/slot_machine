class Api::V1::GiftRequestsController < Api::V1::ApplicationController

	before_action :set_gift_request, only: [:show, :update, :destroy]

	def create
		@gift_request = current_user.gift_requests_sent.build(send_token: params[:send_to_token], gift_type: params[:gift_type])
		if @gift_request.save
			render json: @gift_request
		else
			render json: {
				errors: @gift_request.errors.full_messages.join(", "),
				success: false
			}
		end
	end

	def update
		if @gift_request.update_attributes(gift_request_params)
			render json: @gift_request
		else
			render json: {
				errors: @gift_request.errors.full_messages.join(", "),
				success: false
			}
		end
	end

	def destroy
		@gift_request.destroy
		render json: {
			message: "Gift request deleted.",
			success: true
		}
	end

	def show
		render json: @gift_request
	end

	private

	def gift_request_params
		params.require(:gift_request).permit(:confirmed)
	end

	def set_gift_request
		@gift_request = GiftRequest.where(id: params[:id]).first
		(render json: {message: "Gift request not found. ", success: false}) if @gift_request.blank?
	end

	def current_user
		User.find_by_login_token(params[:login_token])
	end

end