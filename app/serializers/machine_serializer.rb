class MachineSerializer < ActiveModel::Serializer

  attributes :id, :name
  has_one :active_math_model
  has_one :active_in_game_assets
  has_one :active_out_game_assets
  has_many :mini_games

end
