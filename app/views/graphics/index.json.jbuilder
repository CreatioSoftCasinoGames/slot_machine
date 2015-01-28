json.array!(@graphics) do |graphic|
  json.extract! graphic, :id, :name, :machine_id, :description
  json.url graphic_url(graphic, format: :json)
end
