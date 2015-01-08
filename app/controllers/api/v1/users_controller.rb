class Api::V1::UsersController < Api::V1::ApplicationController
	before_action :find_user, only: [:log_spin, :update, :show]

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
      render json: @user
    else
      render json: {
      	errors: @user.errors, status: :unprocessable_entity 
      }
    end

  end

  def show
  	render json: @user
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :country, :fb_id, :stars, :diamond, :current_level, :machine_unlocked, :percentage_win, :num_of_tournament_participated, :biggest_tournament_win_amount, :best_position_in_tournament, :total_spin, :device_id, :biggest_win, :jackpot_win_percent, :total_coins, :gifts, :iap, :bonus_coins, :is_guest)
  end

  def find_user
  	@user = User.find(params[:id])
  end

end
