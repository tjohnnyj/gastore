json.array!(@units) do |unit|
  json.extract! unit, :short_title, :location, :image
  json.url unit_url(unit, format: :json)
end
