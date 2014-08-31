json.array!(@assets) do |asset|
  json.extract! asset, :id, :version, :resource_id, :resource_type, :file
  json.url asset_url(asset, format: :json)
end
