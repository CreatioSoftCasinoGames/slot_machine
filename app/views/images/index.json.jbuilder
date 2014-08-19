json.array!(@images) do |image|
  json.extract! image, :id, :resource_id, :resource_type, :label, :file
  json.url image_url(image, format: :json)
end
