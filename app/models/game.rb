class Game < ActiveRecord::Base

	has_many :math_models
	has_many :assets

	def as_json(options={})
    super({
      only: [:name]
    }.merge(options))
  end

end
