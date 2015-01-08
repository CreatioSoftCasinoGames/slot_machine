class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  before_validation :set_login_details
  before_update :set_coins

  attr_accessor :bet_amount, :won_amount
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :fb_id, uniqueness: true, allow_blank: true

  private

  def set_login_details
  	if is_guest
  		generated_password = SecureRandom.hex(9)
	  	self.email = "guest_#{SecureRandom.hex(8)}@slotapi.com"
	  	self.password = generated_password
	  	self.password_confirmation = generated_password
	  end
  end

  private

  def set_coins
    if bet_amount && won_amount
      self.total_bet = total_bet + bet_amount.to_f
      self.coins_won = coins_won + won_amount.to_f
      self.coins_lost = total_bet - coins_won
    end
  end

end
