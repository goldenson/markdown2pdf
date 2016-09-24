json.extract! post, :id, :description, :image_date, :created_at, :updated_at
json.url post_url(post, format: :json)