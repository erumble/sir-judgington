json.array!(@contestants) do |contestant|
  json.extract! contestant, :id, :first_name, :last_name, :email
  json.url contestant_url(contestant, format: :json)
end
