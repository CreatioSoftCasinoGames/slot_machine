json.array!(@stamps) do |stamp|
  json.extract! stamp, :id, :name, :description, :slot_id
  json.url stamp_url(stamp, format: :json)
end
