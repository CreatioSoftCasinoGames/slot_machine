class DistributableJackpotSerializer < ActiveModel::Serializer
	attributes :id,
	           :amount,
	           :jackpot_type,
	           :winner_id
end