class GraphicSerializer < ActiveModel::Serializer
  attributes :id, :name, :machine_id, :description
end
