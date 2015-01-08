class Api::V1::SessionsController < Api::V1::ApplicationController

	def create
		if params[:user][:fb_id]
			@user = User.where(fb_id: params[:user][:fb_id]).first
		else
			if params[:user][:email] && params[:user][:password]
				@user = User.where(email: params[:user][:email]).first
				(@user = nil) unless @user.valid_password?(params[:user][:password])
			end
		end
		if params[:user][:is_guest]
			if params[:user][:device_id]
				@user = User.where(device_id: params[:user][:device_id]).first_or_initialize
				if @user.blank?
					@user = User.new(device_id: params[:user][:device_id], is_guest: true)
					if @user.save
						render json: {
							user: @user,
							valid: true
						}
						return
					else
						render json: {
							user: @user,
							valid: false,
							errors: @user.errors.full_messages.join(", ")
						}
						return
					end
				end
			end
		end
		render json: @user
	end

end