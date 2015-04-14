class Jackpot < ActiveRecord::Base
	has_many :distributable_jackpots, :dependent => :destroy
end
