class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  before_validation :set_login_details

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

end
