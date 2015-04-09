class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  before_validation :set_login_details, :set_fb_password
  before_update :set_coins
  validates :fb_id, uniqueness: true, allow_blank: true
  
  has_many :login_histories, :dependent => :destroy

  attr_accessor :bet_amount, :won_amount, :previous_login_token, :fb_friends_list

  accepts_nested_attributes_for :login_histories

  def player_since
    created_at.strftime("%B,%Y")
  end

  def self.fetch_by_login_token(login_token)
    self.where(login_token: login_token).first || LoginHistory.where(login_token: login_token).first.user
  end

  def image_url 
    if fb_id
      "http://graph.facebook.com/#{fb_id}/picture"
    end
  end

  private

  def set_login_details
  	if is_guest
  		generated_password = SecureRandom.hex(9)
	  	self.email = "guest_#{SecureRandom.hex(8)}@slotapi.com"
	  	self.password = generated_password
	  	self.password_confirmation = generated_password
	  end
  end

  def set_coins
    if bet_amount && won_amount
      self.total_bet = total_bet + bet_amount.to_f
      self.coins_won = coins_won + won_amount.to_f
      self.coins_lost = total_bet - coins_won
    end
  end

  def set_fb_password
    if fb_id
      generated_password = SecureRandom.hex(9)
      self.password = generated_password
      self.password_confirmation = generated_password    
    end
  end

end
