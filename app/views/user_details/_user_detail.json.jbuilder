json.extract! user_detail, :id, :address, :phone, :city, :province, :zipcode, :country, :created_at, :updated_at
json.url user_detail_url(user_detail, format: :json)
