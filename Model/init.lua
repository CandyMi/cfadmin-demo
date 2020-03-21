local DB = require "DB"

local config = require "config"

local Model = { __Version__ = 0.1 }

function Model.init()

  -- 初始化数据库
  Model._db_ = DB:new {
    host = config.DB_HOST,
    port = config.DB_PORT,
    username = config.DB_USERNAME,
    password = config.DB_PASSWORD,
    charset = config.DB_CHARSET,
    database = config.DB_DATABASE,
    max = config.MAX_POOL,
  }

  return Model._db_:connect()

end

function Model.query( ... )
  return Model._db_:query( ... )
end

function Model.self()
  return Model._db_
end

return Model