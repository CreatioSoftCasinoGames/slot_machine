json.array!(@slots) do |slot|
  json.extract! slot, :id, :name, :description, :game_id
  json.url slot_url(slot, format: :json)
end
