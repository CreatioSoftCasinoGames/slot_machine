class Tournament < ActiveRecord::Base
	belongs_to :machine
	has_many :tournament_users, :dependent => :destroy
	has_many :users, through: :tournament_users
	after_save :sync_tournament_data

	private

	def sync_tournament_data
		Machine.includes(:tournaments).all.each do |machine|
			machine.tournaments.each do |tournament|
				REDIS_CLIENT.ZADD("tournament_sorted_set", tournament.min_entry_level, "players_tournament:#{tournament.id}")
				REDIS_CLIENT.HMSET("players_tournament:#{tournament.id}", "machine_name", machine.name, "machine_id", machine.machine_number, "machine_number", machine.id, "min_entry_level", tournament.min_entry_level, "max_entry_level", tournament.max_entry_level, "seed_money", tournament.seed_money, "timeout", tournament.time_out, "interval", tournament.interval, "points_required", tournament.points_required)
			end
		end
	end
end
