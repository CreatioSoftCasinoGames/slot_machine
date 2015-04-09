class MachineSerializer < ActiveModel::Serializer

  attributes :id, :machine_number, :name, :machine_type, :min_players, :max_players

end
