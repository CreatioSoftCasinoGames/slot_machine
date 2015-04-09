class TournamentSerializer < ActiveModel::Serializer
  attributes :id, :min_player, :max_player, :min_entry_level, :max_entry_level, :seed_money, :time_out
end
