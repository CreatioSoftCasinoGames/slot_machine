class DistributableJackpotSerializer < ActiveModel::Serializer
	attributes :id,
	           :amount,
	           :jackpot_type
end