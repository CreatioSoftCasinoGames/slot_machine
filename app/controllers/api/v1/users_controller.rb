class Api::V1::UsersController < Api::V1::ApplicationController

	def create
		params[:password] = "temp1234" if params[:password].blank?
		@user = User.new(email: params[:email], password: params[:password], password_confirmation: params[:password], first_name: params[:first_name], last_name: params[:last_name], country: params[:country], fb_id: params[:fb_id])
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
		@user = User.where(id: params[:id]).first
		total_bet = @user.total_bet + params[:bet_amount].to_f
		coins_won = @user.coins_won + params[:won_amount].to_f
		coins_lost = total_bet - coins_won
		if @user.update_attributes({ total_bet: total_bet, coins_won: coins_won, coins_lost: coins_lost }	)
			render json: {
				total_bet: @user.total_bet, coins_won: @user.coins_won, coins_lost: @user.coins_lost
			}
	  else
	  	render json: {
	  		errors: @user.errors.full_messages.join(", ")
	  	}
	  end

	end

	def profile_update
		@user = User.where(id: params[:id]).first
    if @user.update_attributes(user_params)
      render json: {
      	stars: @user.stars, total_coins: @user.total_coins, num_of_tournament_participated: @user.num_of_tournament_participated, biggest_tournament_win_amount: @user.biggest_tournament_win_amount, country: @user.country, best_position_in_tournament: @user.best_position_in_tournament
      }
    else
      render json: {
      	errors: @user.errors, status: :unprocessable_entity 
      }
    end

  end

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, :country, :fb_id, :stars, :diamond, :current_level, :machine_unlocked, :percentage_win, :num_of_tournament_participated, :biggest_tournament_win_amount, :best_position_in_tournament, :total_spin, :device_id, :biggest_win, :jackpot_win_percent, :total_coins, :gifts, :iap, :bonus_coins)
  end

end
