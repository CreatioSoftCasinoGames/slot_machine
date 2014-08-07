json.array!(@pay_lines) do |pay_line|
  json.extract! pay_line, :id, :label, :x, :y, :slot_id
  json.url pay_line_url(pay_line, format: :json)
end
