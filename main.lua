local httpd = require "httpd"
local app = httpd:new()

local model = require "Model"
-- 初始化数据库
model.init()

local Cached = require "Cached"
-- 初始化缓存库
Cached.init()

local controllers = require "Controllers"

-- 注册Api文件夹下的路由
controllers.api_init(app)
-- 注册View文件夹下的路由
controllers.view_init(app)
-- 注册Websocket文件夹下的路由
controllers.ws_init(app)
-- 注册Admin文件夹下的路由
controllers.admin_init(app)

-- 注册以上所有路由
-- controllers.all_init(app)

-- 打印上述注册的路由
-- controllers.dump()


-- 开启GZIP/Deflate压缩
app:enable_gzip()

-- 开启静态文件查找, 并设置静态文件缓存周期
app:static("static", 30)

-- 监听端口与监听unix domain socket
app:listen("0.0.0.0", 8000)
-- app:listenx("/var/run/cfadmin.sock", true)

app:run()