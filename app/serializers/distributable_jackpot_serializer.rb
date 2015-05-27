class DistributableJackpotSerializer < ActiveModel::Serializer
	attributes :id,
	           :amount,
	           :jackpot_type,
	           :winner_token,
	           :winner_name,
	           :image_url
end