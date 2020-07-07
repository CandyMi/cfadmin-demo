local Cache = require "Cache"

local config = require "config"

local assert = assert

local Cached = { __Version__ = 0.1 }

function Cached.init()
  Cached.__cache__ = Cache:new{
    host = config.CACHED_HOST,
    port = config.CACHED_PORT,
    auth = config.CACHED_AUTH,
    max = config.CACHED_POOL,
  }
  return Cached.__cache__:connect()
end

function Cached.self()
  return Cached.__cache__
end

return Cached