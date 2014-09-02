class ThemeSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_one :active_asset
  has_many :machines

end
