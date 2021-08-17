# json.array! @pools do |pool|
#     json.partial! "api/v1/resource", resource: pool
# end 

json.partial! partial: "api/v1/resource", collection: @pools, as: :resource