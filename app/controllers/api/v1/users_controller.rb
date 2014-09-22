class Api::V1::UsersController < Api::V1::ApplicationController

	def create
		params[:password] = "temp1234" if params[:password].blank?
		@user = User.new(email: params[:email], password: params[:password], password_confirmation: params[:password], first_name: params[:first_name], last_name: params[:last_name], country: params[:country], fb_id: params[:fb_id])
		if @user.save
			render json: @user
		else
			render json: {
				user: @user,
				errors: @user.errors.full_messages.join(", ")
			}
		end
	end

end