class Tournament < ActiveRecord::Base
	belongs_to :machine
	has_many :tournament_users, :dependent => :destroy
	has_many :users, through: :tournament_users
end
