class TournamentUserSerializer < ActiveModel::Serializer
	attributes :id,
	           :user_id,
	           :tournament_id,
	           :machine_id,
	           :rank,
	           :point,
	           :reward
end