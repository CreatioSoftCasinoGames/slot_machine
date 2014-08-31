class Game < ActiveRecord::Base

	has_many :math_models
	has_many :assets

	has_one :active_math_model, -> { where(math_models: {active: true}) }, class_name: MathModel
	has_one :active_asset, -> { where(assets: {active: true}) }, class_name: Asset

	def as_json(options={})
    super({
      only: [:name]
    }.merge(options))
  end

end
