class CelebrationSerializer < ActiveModel::Serializer
	attributes :four_of_a_kind,
	           :five_of_a_kind,
	           :big_win,
	           :mega_win,
	           :ultimate_win
end