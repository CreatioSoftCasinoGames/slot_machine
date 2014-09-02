json.array!(@machines) do |machine|
  json.extract! machine, :id, :name, :description, :theme_id
  json.url machine_url(machine, format: :json)
end
