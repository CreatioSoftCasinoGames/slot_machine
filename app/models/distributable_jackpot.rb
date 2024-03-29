class DistributableJackpot < ActiveRecord::Base
	belongs_to :jackpot
	belongs_to :user, foreign_key: :winner_id, class_name: "User"
	before_create :set_default_fields
	before_update :increase_jackpot_amount
	after_update :publish_min_jackpot, :publish_major_jackpot
	before_update :update_users
	attr_accessor :jackpot_amount

	def jackpot_type
		jackpot.jackpot_type
	end

	def winner_name
		winner_user = User.where(id: winner_id).first
		if winner_user.try(:first_name)
    	[winner_user.try(:first_name), winner_user.try(:last_name)].join(" ")
    else
    	"Guest User"
    end
  end

  def winner_token
  	winner_user = User.where(id: winner_id).first.login_token
  end

  def image_url
  	fb_id = User.where(id: winner_id).first.try(:fb_id)
    if fb_id
      "https://graph.facebook.com/#{fb_id}/picture"
    end
  end

  def winner_token
  	User.where(id: winner_id).first.try(:login_token)
  end

  def self.update_jackpot
  	min_jackpot = Jackpot.where(jackpot_type: "Min").first.distributable_jackpots.where(active: true).last
  	major_jackpot = Jackpot.where(jackpot_type: "Major").first.distributable_jackpots.where(active: true).last
  	if min_jackpot.present?
  		new_min = REDIS_CLIENT.HMGET("jackpot_details", "min_amount")[0].to_i 
  		min_jackpot.update_attributes(amount: new_min)
  	end
  	if major_jackpot.present?
  		new_major = REDIS_CLIENT.HMGET("jackpot_details", "major_amount")[0].to_i 
  		major_jackpot.update_attributes(amount: new_major)
  	end
  end

	def self.mark_as_distributed
		distributable_jackpots = DistributableJackpot.where(active: true)
		if distributable_jackpots.present?
			distributable_jackpots.each do |distributable_jackpot|
				if distributable_jackpot.jackpot.jackpot_type == "Min" && distributable_jackpot.created_at <= Time.zone.now - 4.hours
					id = find_winner_id(distributable_jackpot.created_at.to_time)
					# if (Time.zone.now - distributable_jackpot.updated_at) > 14400.seconds
					distributable_jackpot.update_attributes(winner_id: id, active: false)
					create_and_publish_jackpot(distributable_jackpot)
					# end
				elsif distributable_jackpot.created_at.to_date <= (Time.zone.now - 1.days).to_date
					id = find_winner_id(distributable_jackpot.created_at.to_time)
					distributable_jackpot.update_attributes(winner_id: id, active: false)
					create_and_publish_jackpot(distributable_jackpot)
				end	
			end
		else
			mini_jackpot = Jackpot.where(jackpot_type: "Min").first
			major_jackpot = Jackpot.where(jackpot_type: "Major").first

			DistributableJackpot.create(jackpot_id: mini_jackpot.id, amount: mini_jackpot.seed_amount, seed_amount: mini_jackpot.seed_amount)
			DistributableJackpot.create(jackpot_id: major_jackpot.id, amount: major_jackpot.seed_amount, seed_amount: major_jackpot.seed_amount)
		end
	end

	def self.create_and_publish_jackpot(distributable_jackpot)
		DistributableJackpot.create(jackpot_id: distributable_jackpot.jackpot.id, seed_amount: distributable_jackpot.seed_amount, amount: distributable_jackpot.seed_amount)
		REDIS_CLIENT.PUBLISH("jackpotWinner", {publish_type: "jackpot_winner", winner_token: distributable_jackpot.winner_token, winner_name: distributable_jackpot.winner_name, jackpot_type: distributable_jackpot.jackpot.jackpot_type , amount: distributable_jackpot.amount, image_url: distributable_jackpot.image_url}.to_json)
	end

	def self.find_winner_id(jackpot_distribution_time)
		# played_users = User.where("last_logout_time > ? OR current_sign_in_at > last_logout_time", jackpot_distribution_time)
		played_users = User.where("updated_at > ?", jackpot_distribution_time)
		fb_user_count = played_users.where(is_fb_connected: true).count
		guest_user_count = played_users.where(is_fb_connected: false).count

		if fb_user_count < 0
			user_ids = played_users.where(is_fb_connected: false).collect(&:id)
			id = user_ids[rand(user_ids.length)]
		elsif guest_user_count < 0
			user_ids = played_users.where(is_fb_connected: true).collect(&:id)
			id = user_ids[rand(user_ids.length)]
		else
			percent = rand(100)
			id = ""

			if percent > 70
				user_ids = played_users.where(is_fb_connected: false).collect(&:id)
				id = user_ids[rand(user_ids.length)]
			else
				fb_user_ids = played_users.where(is_fb_connected: true).collect(&:id)
				id = fb_user_ids[rand(fb_user_ids.length)]
			end

		end

	end

	private

	def set_default_fields
		self.seed_amount = jackpot.seed_amount
		self.player_percentage = jackpot.player_percent
	end

	def increase_jackpot_amount
		if jackpot_amount
			self.amount = amount + jackpot_amount.to_f
		end
	end

	def update_users
		if self.changes.include?(:is_distributed)
			user_ids = User.pluck(:id) - [self.winner_id]
			if self.jackpot.jackpot_type == "Min"
				user_ids.each do |user_id|
					User.where(id: user_id).first.update_attributes(mini_jackpot_status: true)
				end
			else
				user_ids.each do |user_id|
					User.where(id: user_id).first.update_attributes(major_jackpot_status: true)
				end
			end
		end
	end

	def publish_min_jackpot
		if self.jackpot.jackpot_type == "Min" && self.changes.include?(:amount)
			REDIS_CLIENT.SET("min_jackpot", Jackpot.where(jackpot_type: "Min").first.distributable_jackpots.where(active: true).last.try(:amount))
		end
	end
	def publish_major_jackpot
		if self.changes.include?(:amount) && self.jackpot.jackpot_type == "Major"
			REDIS_CLIENT.SET("major_jackpot", Jackpot.where(jackpot_type: "Major").first.distributable_jackpots.where(active: true).last.try(:amount))
		end
	end

end
