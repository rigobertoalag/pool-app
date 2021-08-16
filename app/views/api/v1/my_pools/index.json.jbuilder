json.array! @pools do |pool|
    json.type "my_pools"
    json.id pool.id
    json.attributes pool.attributes
end 