class Machine < ActiveRecord::Base

	has_many :math_models
	has_one :active_math_model, -> { where(math_models: {active: true}) }, class_name: "MathModel"

	has_many :mini_games

	belongs_to :game

end
