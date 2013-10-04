json.array!(@live_hotels) do |live_hotel|
  json.extract! live_hotel, 
  json.url live_hotel_url(live_hotel, format: :json)
end
