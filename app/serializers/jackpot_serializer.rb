class JackpotSerializer < ActiveModel::Serializer
  attributes :id, :jackpot_type, :seed_amount, :player_percent
end
