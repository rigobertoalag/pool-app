#json.(@pool, :id, :title, :description, :user_id, :expires_at)
json.partial! "api/v1/resource", resource: @pool