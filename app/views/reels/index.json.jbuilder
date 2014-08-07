json.array!(@reels) do |reel|
  json.extract! reel, :id, :stamp_id, :position
  json.url reel_url(reel, format: :json)
end
