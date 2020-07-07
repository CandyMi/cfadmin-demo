local Cached = require "Cached"
local Cache = Cached.self()


local user = {}

function user.autoincrement(key)
  return Cache:incr(key)
end

function user.autodecrement(key)
  return Cache:decr(key)
end

return user