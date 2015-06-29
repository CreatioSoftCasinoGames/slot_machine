class GameVersionSerializer < ActiveModel::Serializer
  attributes :id, :version, :require_update
end
