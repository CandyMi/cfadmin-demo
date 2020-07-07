return {

  -- 数据库配置
  DB_HOST = "localhost",       -- 数据库链接地址
  DB_PORT = 3306,              -- 数据库端口
  DB_POOL = 100,               -- 连接池大小
  DB_CHARSET = "utf8mb4",      -- 数据库字符集
  DB_DATABASE = "cfadmin",     -- 指定DB
  DB_USERNAME = "root",        -- 用户名
  DB_PASSWORD = "123456789",   -- 密码

  -- Redis配置
  CACHED_HOST = "localhost",   -- REDIS地址
  CACHED_PORT = 6379,          -- REDIS端口
  CACHED_POOL = 100,           -- REDIS连接池
  CACHED_AUTH = nil,           -- REDIS密码
  CACHED_DB = 0,               -- REDIS默认DB

}