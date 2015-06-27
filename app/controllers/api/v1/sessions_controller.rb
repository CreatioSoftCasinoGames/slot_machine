class Api::V1::SessionsController < Api::V1::ApplicationController

	def create

		#Check previous versions update status
		@user_version = User.where(device: params[:device], game_version: params[:game_version]).first
		@greater_version = User.where("game_version > ?", params[:game_version].to_s)
		update_required = false
		if @greater_version.count > 0
			update_required = true
		elsif @user_version.present?
			update_required = @user_version.update_required
		else
			update_required = false
		end

		if params[:fb_id] && params[:device_id]
			if User.where(fb_id: params[:fb_id]).first.blank?
				@guest_user = User.where(device_id: params[:device_id], is_fb_connected: false, fb_id: nil).first
				if @guest_user.present?
					@user = @guest_user.dup
					@user.attributes = {parent_id: @guest_user.id, device_id: params[:device_id], is_guest: false, fb_id: params[:fb_id], email: params[:fb_id]+"@facebook.com", is_fb_connected: true, device: params[:device], game_version: params[:game_version], update_required: update_required}
					if @user.save
						@guest_user.update_attributes(is_fb_connected: true)
						@success = true
						@new_user = true
					else
						@success = false
						@messages = @user.errors.full_messages.join(", ")
					end
				else
					facebook_sync(params, update_required)
				end
			else
				facebook_sync(params, update_required)
			end 
		elsif params[:is_guest] && params[:device_id]
			@user = User.where(device_id: params[:device_id], is_guest: true).first_or_initialize
			@user.attributes = {device: params[:device], game_version: params[:game_version], update_required: update_required}
			if @user.new_record?
				if @user.save
					@success = true
				else
					@success = false
					@message = @user.errors.full_messages.join(", ")
				end
			end
		elsif params[:is_bot]
			@user = User.create(first_name: params[:first_name], last_name: params[:last_name], is_bot: true)
			if @user.save
				@success = true
			else
				@success = false
				@message = @user.errors.full_messages.join(", ")
			end
		end

		if @user.present?
			login_token = SecureRandom.hex(5)
			if @user.update_attributes(login_token: login_token, current_sign_in_at: Time.now, online: true, login_histories_attributes: {id: nil, active: true, login_token: login_token })
				@user.previous_login_token = @user.login_histories.order("created_at desc").limit(2).last.try(:login_token)
				render json: @user
			else
				render json: {
					errors: @user.errors.full_messages.join(", "),
					success: false
				}
			end
		else
			render json: {
				errors: @message,
				success: false
			}
		end
	end

	def destroy
		@user = User.fetch_by_login_token(params[:id])
		if @user.present?
			login_history_id = @user.login_histories.where(login_histories: {login_token: params[:id]}).first.id
			if @user.update_attributes(online: false, last_logout_time: Time.now, login_histories_attributes: {id: login_history_id ,active: false})
				# REDIS_CLIENT.srem("game_players", "game_player:#{params[:id]}")
				render json: {
					success: true,
					message: "You have been signed out successfully!"
				}
			else
				render json: {
					errors: @user.errors.full_messages.join(", "),
					success: false
				}
			end
		else
			render json: {
				success: false,
				message: "Session does not exists"
			}
		end
	end

	private 

	def facebook_sync(params, update_required)
		@user = User.where(fb_id: params[:fb_id]).first_or_initialize
		@user.attributes = {fb_friends_list: params[:fb_friends_list], device_id: params[:device_id], device: params[:device], game_version: params[:game_version], update_required: update_required}
		if @user.new_record?
			email = params[:email].present? ? params[:email] : params[:fb_id]+"@facebook.com"
			@user.attributes = {email: email, first_name: params[:first_name], last_name: params[:last_name], fb_friends_list: params[:fb_friends_list]}
			if @user.save
				@success = true
			else
				@success = false
				@message = @user.errors.full_messages.join(" , ")
			end
		else
			@user.update_attributes({first_name: params[:first_name], last_name: params[:last_name], fb_friends_list: params[:fb_friends_list]})
		end
	end

end