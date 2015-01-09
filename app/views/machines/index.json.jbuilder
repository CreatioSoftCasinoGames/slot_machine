json.array!(@machines) do |machine|
  json.extract! machine, :id, :name, :description, :game_id
  json.url machine_url(machine, format: :json)
end
