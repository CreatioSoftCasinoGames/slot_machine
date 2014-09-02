class MiniGameSerializer < ActiveModel::Serializer

  attributes :id, :name
  has_one :active_asset

end
