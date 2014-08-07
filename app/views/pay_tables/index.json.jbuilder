json.array!(@pay_tables) do |pay_table|
  json.extract! pay_table, :id, :count, :stamp_id, :slot_id, :points
  json.url pay_table_url(pay_table, format: :json)
end
