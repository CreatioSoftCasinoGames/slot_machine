class Game < ActiveRecord::Base

	has_many :slots

	def as_json(options={})
    super({
      only: [:name]
    }.merge(options))
  end

end
