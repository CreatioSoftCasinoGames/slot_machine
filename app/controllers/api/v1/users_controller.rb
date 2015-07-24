class Api::V1::UsersController < Api::V1::ApplicationController
	before_action :find_user, only: [:log_spin, :view_jackpot_winner, :winner_jackpot, :update, :show, :my_friends, :winner_jackpot, :friend_request_sent, :my_friend_requests, :sent_gift, :received_gift, :delete_friend]

	def create
		@user = User.new(user_params)
		if @user.save
			render json: {
				user: @user,
				valid: true
			}
		else
			render json: {
				user: @user,
				valid: false,
				errors: @user.errors.full_messages.join(", ")
			}
		end
	end

	def log_spin
		if @user.update_attributes(total_bet: params[:total_bet], coins_won: params[:coins_won], coins_lost: params[:coins_lost])
			render json: @user
	  else
	  	render json: {
	  		errors: @user.errors.full_messages.join(", ")
	  	}
	  end

	end

	def fetch_country
		data = GeoIP.new('GeoIP.dat').country(request.ip)
		render json: data
	end

	def update
		if @user.update_attributes(user_params)
      render json: {
      	success: true
      }
    else
      render json: {
      	success: true,
      	errors: @user.errors, status: :unprocessable_entity 
      }
    end

  end

  def show
  	render json: @user
  end

  def friend_request_sent
		render json: @user.friend_requests_sent.where(confirmed: false)
	end

	def my_friend_requests
		render json: @user.unconfirmed_friend_requests
	end

	def my_friends
		gift_requests_sent_witnin_24_hours = @user.gift_requests_sent_witnin_24_hours
		friends = @user.friends.collect do |friend|
			{
				login_token: friend.login_token,
				online: friend.online,
				current_level: friend.current_level,
				full_name: friend.full_name,
				image_url: friend.image_url,
				gift_sent: gift_requests_sent_witnin_24_hours.include?(friend.id)
			}
		end
		render json: friends
	end

	def delete_friend
		@friend = Friendship.where(user_id: @user.id, friend_id: User.fetch_by_login_token(params[:friend_token])).first.delete
		@friend1 = Friendship.where(user_id: User.fetch_by_login_token(params[:friend_token]), friend_id: @user.id).first.delete
		render json: {
			success: true
		}
	end

	def sent_gift
		render json: @user.gift_requests_sent.where(confirmed: false)
	end

	def received_gift
		render json: @user.unconfirmed_gift_requests.where("created_at > ?", Time.now - 24.hour)
	end

	def get_reward
		@tournament_user = User.fetch_by_login_token(params[:id]).tournament_users.where(status: false)
		if @tournament_user.blank?
			render json: []
		else
			render json: @tournament_user.as_json({
				only: [:id, :rank, :point, :prize],
				methods: [:machine_id, :machine_name]
			})
		end
	end

	def winner_jackpot	
		@presentable_jackpots = Jackpot.where(jackpot_type: params[:type]).first.distributable_jackpots.where("updated_at >= ? and active = ? and winner_id is not ?", Time.now - 2.day, false, nil)
		@distributable_jackpots = @presentable_jackpots.where("updated_at >= ? and updated_at <= ?", @user.last_logout_time, @user.current_sign_in_at)
		render json: @distributable_jackpots.as_json({
			only:[:id, :amount],
			methods: [:winner_name, :winner_token, :image_url, :jackpot_type]
		})
		
	end

	# def ask_for_gift_to
	# 	render json: @user.gift_requests_sent.where(is_asked: true)
	# end

	# def ask_for_gift_by
	# 	render json: @user.unconfirmed_gift_requests.where(is_asked: true)
	# end

  private

  def user_params
  	celebration_id = @user.celebration.try(:id)
  	params[:user][:celebration_attributes][:id] = celebration_id if params[:user] && params[:user][:celebration_attributes]
  	(params[:user][:celebration_attributes][:celebrations] = params[:user][:celebration_attributes][:celebrations].split(",")[0..4].join(",") + ",") rescue nil
  	(params[:user][:celebration_attributes][:reward] = params[:user][:celebration_attributes][:reward].split(",")[0..4].join(",") + ",") rescue nil
    params.require(:user).permit(:email, :bet_index, :bet_per_line, :last_logout_time, :password, :password_confirmation, :first_name, :last_name, :country, :fb_id, :stars, :diamonds, :current_level, :machine_unlocked, :percentage_win, :num_of_tournament_participated, :version, :biggest_tournament_win_amount, :best_position_in_tournament, :total_spin, :device_id, :biggest_win, :jackpot_win_percent, :total_coins, :gifts, :iap, :bonus_coins, :is_guest, :mini_jackpot_status, :major_jackpot_status, :total_iap_made,
    	celebration_attributes: [:celebrations, :reward, :id])
  end

  def find_user
  	# @user = User.where(login_token: params[:id]).first
  	@user = User.fetch_by_login_token(params[:id])
  	(render json: {message: "User not found", success: false}) if @user.blank?
  end

end
