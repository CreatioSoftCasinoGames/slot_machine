class Api::V1::UsersController < Api::V1::ApplicationController
	before_action :find_user, only: [:log_spin, :view_jackpot_winner, :update, :show, :my_friends, :winner_jackpot, :friend_request_sent, :my_friend_requests, :sent_gift, :received_gift, :delete_friend, :get_reward]

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
		if @user.update_attributes({bet_amount: params[:bet_amount], won_amount: params[:won_amount]})
			render json: @user
	  else
	  	render json: {
	  		errors: @user.errors.full_messages.join(", ")
	  	}
	  end

	end

	def update
		
    if @user.update_attributes(user_params)
      render json: {
      	success: true
      }
    else
      render json: {
      	success: false,
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

	# def send_in_game_gift
	# 	render json: InGameGift.all
	# end

	def my_friends
		render json: @user.friends.as_json({
			only: [:login_token, :online],
			methods: [:full_name, :image_url]
		})
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
		render json: @user.unconfirmed_gift_requests
	end

	def get_reward
		@tournament_user = User.fetch_by_login_token(params[:id]).tournament_users.where(status: false)
		render json: @tournament_user.as_json({
			only: [:id, :rank, :point, :prize],
			methods: [:machine_id]
		})
	end

	def winner_jackpot
		@distributable_jackpot = Jackpot.where(jackpot_type: params[:type]).first.distributable_jackpots.where(winner_id: User.fetch_by_login_token(params[:id]).id)
		render json: @distributable_jackpot.as_json({
			only: [:amount]
		})
	end

	def view_jackpot_winner
		@distributable_jackpots = Jackpot.where(jackpot_type: params[:type]).first.distributable_jackpots.where("created_at >= ? and active = ?", Date.today - 2.day, false)
		p @distributable_jackpots
		@presentable_jackpots = @distributable_jackpots.where("created_at >= ? and created_at <= ?", @user.last_logout_time, @user.current_sign_in_at)
		p @presentable_jackpots
		render json: @presentable_jackpots
		
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
    params.require(:user).permit(:email, :last_logout_time, :password, :password_confirmation, :first_name, :last_name, :country, :fb_id, :stars, :diamonds, :current_level, :machine_unlocked, :percentage_win, :num_of_tournament_participated, :version, :biggest_tournament_win_amount, :best_position_in_tournament, :total_spin, :device_id, :biggest_win, :jackpot_win_percent, :total_coins, :gifts, :iap, :bonus_coins, :is_guest, :mini_jackpot_status, :major_jackpot_status, :total_iap_made,
    	celebration_attributes: [:celebrations, :reward, :id])
  end

  def find_user
  	@user = User.where(login_token: params[:id]).first
  	(render json: {message: "User not found", success: false}) if @user.blank?
  end

end
