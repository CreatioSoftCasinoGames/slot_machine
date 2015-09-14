class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  before_validation :set_login_details, :set_fb_password
  before_update :set_coins
  validates :fb_id, uniqueness: true, allow_blank: true
  validate :set_fb_friends
  
  has_many :login_histories, :dependent => :destroy
  has_many :friend_requests, :dependent => :destroy, foreign_key: "requested_to_id"
  has_many :friend_requests_sent, :dependent => :destroy, foreign_key: "user_id", class_name: "FriendRequest"
  has_many :unconfirmed_friend_requests, -> {where(confirmed: false)}, class_name: "FriendRequest", foreign_key: "requested_to_id"
  has_many :friendships, :dependent => :destroy
  has_many :friends, through: :friendships
  has_many :gift_requests, :dependent => :destroy, foreign_key: "send_to_id"
  has_many :gift_requests_sent, :dependent => :destroy, class_name: "GiftRequest", foreign_key: "user_id"
  has_many :unconfirmed_gift_requests, -> { where(confirmed: false) }, class_name: "GiftRequest", foreign_key: "send_to_id"
  has_one :celebration, :dependent => :destroy
  has_many :tournament_users, :dependent => :destroy
  has_many :tournament, through: :tournament_users
  has_many :distributable_jackpots, foreign_key: "winner_id", class_name: "DistributableJackpot"
  before_update :check_device_changed
  before_create :update_first_fb_sync
  before_create :add_unique_id
  validate :check_previous_level
  validate :check_previous_stars

  has_paper_trail

  attr_accessor :bet_amount, :won_amount, :previous_login_token, :fb_friends_list, :device_changed, :first_fb_sync

  accepts_nested_attributes_for :login_histories
  accepts_nested_attributes_for :celebration

  def player_since
    created_at.strftime("%B,%Y")
  end

  def gift_count
    unconfirmed_gift_requests.where("created_at > ?", Time.now - 24.hour).count
  end

  def self.fetch_by_login_token(login_token)
    self.where(login_token: login_token).first || LoginHistory.where(login_token: login_token).first.user
  end

  def gift_requests_sent_witnin_24_hours
    gift_requests_sent.where(gift_requests: {send_to_id: friends.collect(&:id)}).where("gift_requests.created_at > ?", (Time.now - 24.hours)).collect(&:send_to_id).uniq
  end

  def full_name
    if first_name
      [first_name, last_name].join(" ")
    else
      "Guest User"
    end
  end

  def image_url 
    if fb_id
      "https://graph.facebook.com/#{fb_id}/picture"
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

  def set_fb_friends
    if fb_friends_list
      user_ids = User.where(fb_id: fb_friends_list).collect(&:id)
      friend_ids = self.friends.collect(&:id)
      new_friend_ids = user_ids - friend_ids
      deleted_friends_ids = friend_ids - user_ids
      new_friend_ids.each do |friend_id|
        if Friendship.where(user_id: self.id, friend_id: friend_id).first.blank?
          Friendship.create(user_id: self.id, friend_id: friend_id)
          Friendship.create(user_id: friend_id, friend_id: self.id)
        end
      end
      deleted_friends_ids.each do |deleted_friend_id|
        Friendship.where(user_id: self.id, friend_id: deleted_friend_id).first.delete
        Friendship.where(user_id: deleted_friend_id, friend_id: self.id).first.delete
      end
    end
  end

  def check_device_changed
    self.device_changed = true if self.changes.include?(:device_id)
    true
  end
   
  def add_unique_id
    unique_value = SecureRandom.hex(4)
    self.unique_id = unique_value
  end

  def update_first_fb_sync
    self.first_fb_sync = true if self.changes.include?(:fb_id)
  end

  def check_previous_level
    if self.fb_id
      level_changes = self.changes["current_level"]
      self.errors.add(:current_level, "Current level cant be smaller than previous level") if (level_changes && (level_changes.first.to_f > level_changes.last.to_f))
      
    end
  end

  def check_previous_stars
    if self.fb_id
      stars_changes = self.changes["stars"]
      self.errors.add(:stars, "Current stars cant be smaller than previous starts") if (stars_changes && (stars_changes.first.to_f > stars_changes.last.to_f))
    end
  end

end
