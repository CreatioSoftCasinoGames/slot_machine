class DistributableJackpot < ActiveRecord::Base
	belongs_to :jackpot
	belongs_to :user, foreign_key: :winner_id, class_name: "User"
	before_create :set_default_fields
	before_update :increase_jackpot_amount
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
      "http://graph.facebook.com/#{fb_id}/picture"
    end
  end

  def winner_token
  	User.where(id: winner_id).first.try(:login_token)
  end

	def self.mark_as_distributed
		distributable_jackpots = DistributableJackpot.where(active: true)
		if distributable_jackpots.present?
			distributable_jackpots.each do |distributable_jackpot|
				percent = rand(100)
				id = ""
				
				if percent > 70
					user_ids = User.where(is_fb_connected: false).collect(&:id)
					id = user_ids[rand(user_ids.length)]
				else
					fb_user_ids = User.where(is_fb_connected: true).collect(&:id)
					id = fb_user_ids[rand(fb_user_ids.length)]
				end
				if distributable_jackpot.jackpot.jackpot_type == "Min"
					distributable_jackpot.update_attributes(winner_id: id, active: false)
					DistributableJackpot.create(jackpot_id: distributable_jackpot.jackpot.id, seed_amount: distributable_jackpot.seed_amount, amount: distributable_jackpot.seed_amount)
					REDIS_CLIENT.PUBLISH("jackpotWinner", {winner_token: distributable_jackpot.winner_token, winner_name: distributable_jackpot.winner_name, jackpot_type: distributable_jackpot.jackpot.jackpot_type , amount: distributable_jackpot.amount, image_url: distributable_jackpot.image_url}.to_json)
				elsif distributable_jackpot.created_at.to_date == (Time.now - 1.days).to_date
					distributable_jackpot.update_attributes(winner_id: id, active: false)
					DistributableJackpot.create(jackpot_id: distributable_jackpot.jackpot.id, seed_amount: distributable_jackpot.seed_amount, amount: distributable_jackpot.seed_amount)
					REDIS_CLIENT.PUBLISH("jackpotWinner", {winner_token: distributable_jackpot.winner_token, winner_name: distributable_jackpot.winner_name, jackpot_type: distributable_jackpot.jackpot.jackpot_type , amount: distributable_jackpot.amount, image_url: distributable_jackpot.image_url}.to_json)
				end	
			end
		else
			mini_jackpot = Jackpot.where(jackpot_type: "Min").first
			major_jackpot = Jackpot.where(jackpot_type: "Major").first

			DistributableJackpot.create(jackpot_id: mini_jackpot.id, amount: mini_jackpot.seed_amount, )
			DistributableJackpot.create(jackpot_id: major_jackpot.id, amount: major_jackpot.seed_amount)
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

end
