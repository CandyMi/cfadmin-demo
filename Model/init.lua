local DB = require "DB"

local config = require "config"

local assert = assert

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
    max = config.DB_POOL,
  }

  return Model._db_:connect()

end

function Model.query( ... )
  return assert(Model._db_, "Model needs to initialize DB first"):query( ... )
end

function Model.self()
  return assert(Model._db_, "Model needs to initialize DB first")
end

return Model