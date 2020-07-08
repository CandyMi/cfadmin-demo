local lfs = require "lfs"

local Model = require "Model"

local admin = require "admin"
local admin_view = require "admin.view"

local config = require "config"

local FOLDER = config.FOLDER and config.FOLDER .. "/" or "script/"

local CONTROLLER = "Controllers/"

-- 检查是否为lua文件
local function is_lua_file(filename)
  return string.find(filename, ".+%.lua$")
end

-- 移除后缀名
local function remove_suffix( filename )
  return string.sub(filename, 1, string.find(filename , "%.") - 1)
end

-- 获取完整路径
local function get_path(folder)
  return CONTROLLER .. folder .. "/"
end

-- 拼接路径
local function to_path(path, filename)
  return path .. filename
end

-- 包装
local function require_file(path, filename)
  return require(string.gsub(path .. filename, "/", "."))
end

-- 注册路由
local function registery_route(app, ctr, types, dir)
  if types == 'API' then -- 注册API路由
    -- 获取Api完整路径
    local API = get_path("Api") .. (dir or "")

    for filename in lfs.dir(FOLDER .. API) do
      local stat = lfs.attributes(FOLDER .. API .. filename)

      if stat['mode'] ~= 'directory' and is_lua_file(filename) then

        local api = require_file(API, remove_suffix(filename))
        assert(type(api) == 'table', "invalide lua file: " .. to_path(API, filename))

        local path = type(api.path) == 'string' and api.path or "/api/" .. remove_suffix((dir or "") .. filename)
        local route = type(api.route) == 'function' and api.route or nil

        if path and route then
          app:api(path, route)
          ctr[#ctr+1] = { path = path, route = route, file_path = to_path(API, filename) }
        end
      end

      if stat['mode'] == 'directory' and filename ~= '.' and filename ~= '..' then
        registery_route(app, ctr, types, dir and dir .. filename .. "/" or filename .. "/")
      end

    end
  end

  if types == "VIEW" then
    -- 注册View路由
    local VIEW = get_path("View") .. (dir or "")

    for filename in lfs.dir(FOLDER .. VIEW) do
      local stat = lfs.attributes(FOLDER .. VIEW .. filename)
      if stat['mode'] ~= 'directory' and is_lua_file(filename) then

        local view = require_file(VIEW, remove_suffix(filename))
        assert(type(view) == 'table', "invalide lua file: " .. to_path(VIEW, filename))

        local path = type(view.path) == 'string' and view.path or "/" .. remove_suffix((dir or "") .. filename)
        local route = type(view.route) == 'function' and view.route or nil

        if path and route then
          app:use(path, route)
          ctr[#ctr+1] = { path = path, route = route, file_path = to_path(VIEW, filename) }
        end
      end

      if stat['mode'] == 'directory' and filename ~= '.' and filename ~= '..' then
        registery_route(app, ctr, types, dir and dir .. filename .. "/" or filename .. "/")
      end

    end
  end

  if types == "WS" then
    -- 注册View路由
    local WS = get_path("Websocket")   -- 获取View完整路径

    for filename in lfs.dir(FOLDER .. WS) do
      if is_lua_file(filename) then

        local ws = require_file(get_path("Websocket"), remove_suffix(filename))
        assert(type(ws) == 'table', "invalide lua file: " .. to_path(WS, filename))
        assert(type(ws.on_open) == 'function', "Wesocket need on_open method")
        assert(type(ws.on_message) == 'function', "Wesocket need on_message method")
        assert(type(ws.on_error) == 'function', "Wesocket need on_error method")
        assert(type(ws.on_close) == 'function', "Wesocket need on_close method")
        local path = type(ws.path) == 'string' and ws.path or "/" .. remove_suffix(filename)
        local route = type(ws) == 'table' and ws or nil

        if path and route then
          app:ws(path, route)
          ctr[#ctr+1] = { path = path, route = route, file_path = to_path(WS, filename) }
        end

      end
    end
  end

  if types == "ADMIN" then
    -- 获取Admin完整路径
    local ADMIN = get_path("Admin") .. (dir or "")

    for filename in lfs.dir(FOLDER .. ADMIN) do
      local stat = lfs.attributes(FOLDER .. ADMIN .. filename)
      if stat['mode'] ~= 'directory' and is_lua_file(filename) then

        local cls = require_file(ADMIN , remove_suffix(filename))
        assert(type(cls) == 'table', "invalide lua file: " .. to_path(ADMIN, filename))

        local use_path = type(cls.use_path) == 'string' and cls.use_path
        local use_route = type(cls.use_route) == 'function' and cls.use_route or nil

        local api_path = type(cls.api_path) == 'string' and cls.api_path
        local api_route = type(cls.api_route) == 'function' and cls.api_route or nil

        if use_path and use_route then
          admin_view.use(use_path, use_route)
          ctr[#ctr+1] = { path = use_path, route = use_route, file_path = to_path(ADMIN, filename)}
        end

        if api_path and api_route then
          admin_view.api(api_path, api_route)
          ctr[#ctr+1] = { path = api_path, route = api_route, file_path = to_path(ADMIN, filename)}
        end

      end

      if stat['mode'] == 'directory' and filename ~= '.' and filename ~= '..' then
        -- print(FOLDER .. ADMIN .. filename)
        registery_route(app, ctr, types, dir and dir .. filename .. "/" or filename .. "/")
      end

    end

  end
end


local Controllers = { __Version__ = 0.1, api_routes = {}, view_routes = {}, admin_routes = {}, ws_routes = {} }

-- 注册接口
function Controllers.api_init(app)
  return registery_route(app, Controllers.api_routes, "API")
end

-- 注册页面
function Controllers.view_init(app)
  return registery_route(app, Controllers.view_routes, "VIEW")
end

-- 注册websocket
function Controllers.ws_init(app)
  return registery_route(app, Controllers.ws_routes, "WS")
end

-- 注册后台
function Controllers.admin_init(app, init_db)

  -- 检查是否已经初始化DB.
  local db = assert(Model.self(), "Please init Model.")

  -- 初始化内置页面
  admin.init_page(app, db)

  -- 如果传递此参数则会初始化数据库, 多次初始化是无害的.
  if not init_db then
    admin.init_db(app, db)
  end

  return registery_route(app, Controllers.admin_routes, "ADMIN")

end

-- 初始化Admin/Api/View
function Controllers.all_init(app, ...)

  Controllers.api_init(app)

  Controllers.view_init(app)

  Controllers.ws_init(app)

  Controllers.admin_init(app, ...)

  return true

end

-- 打印已经注册的用户路由
function Controllers.dump()

  -- 打印API路由
  if #Controllers.api_routes > 0 then
    print("\n---------------------------------------------------- \27[35mAPI Routes\27[0m ----------------------------------------------------")
    for _, item in ipairs(Controllers.api_routes) do
      local ROUTE = string.format("| ROUTE | \27[96m%s\27[0m  ", item.path)
      local FILE =  string.format("| FILE | \27[96m%s\27[0m  ", item.file_path)
      if #ROUTE < 58 then
        ROUTE = ROUTE .. string.rep(" ", 58 - #ROUTE)
      end
      if #FILE < 68 then
        FILE = FILE .. string.rep(" ", 68 - #FILE) .. "|"
      end
      print(ROUTE, FILE)
    end
    print("--------------------------------------------------------------------------------------------------------------------")
  end

  -- 打印USE路由
  if #Controllers.view_routes > 0 then
    print("\n---------------------------------------------------- \27[35mVIEW Routes\27[0m ---------------------------------------------------")
    for _, item in ipairs(Controllers.view_routes) do
      local ROUTE = string.format("| ROUTE | \27[96m%s\27[0m  ", item.path)
      local FILE =  string.format("| FILE | \27[96m%s\27[0m  ", item.file_path)
      if #ROUTE < 58 then
        ROUTE = ROUTE .. string.rep(" ", 58 - #ROUTE)
      end
      if #FILE < 68 then
        FILE = FILE .. string.rep(" ", 68 - #FILE) .. "|"
      else
        FILE = FILE .. "|"
      end
      print(ROUTE, FILE)
    end
    print("--------------------------------------------------------------------------------------------------------------------")
  end

  -- 打印WS路由
  if #Controllers.ws_routes > 0 then
    print("\n---------------------------------------------------- \27[35mWS Routes\27[0m -----------------------------------------------------")
    for _, item in ipairs(Controllers.ws_routes) do
      local ROUTE = string.format("| ROUTE | \27[96m%s\27[0m  ", item.path)
      local FILE =  string.format("| FILE | \27[96m%s\27[0m  ", item.file_path)
      if #ROUTE < 58 then
        ROUTE = ROUTE .. string.rep(" ", 58 - #ROUTE)
      end
      if #FILE < 68 then
        FILE = FILE .. string.rep(" ", 68 - #FILE) .. "|"
      else
        FILE = FILE .. "|"
      end
      print(ROUTE, FILE)
    end
    print("--------------------------------------------------------------------------------------------------------------------")
  end

  -- 打印ADMIN路由
  if #Controllers.admin_routes > 0 then
    print("\n---------------------------------------------------- \27[35mADMIN Routes\27[0m --------------------------------------------------")
    for _, item in ipairs(Controllers.admin_routes) do
      local ROUTE = string.format("| ROUTE | \27[96m%s\27[0m  ", item.path)
      local FILE =  string.format("| FILE | \27[96m%s\27[0m  ",  item.file_path)
      if #ROUTE < 58 then
        ROUTE = ROUTE .. string.rep(" ", 58 - #ROUTE)
      end
      if #FILE < 68 then
        FILE = FILE .. string.rep(" ", 68 - #FILE) .. "|"
      else
        FILE = FILE .. "|"
      end
      print(ROUTE, FILE)
    end
    print("--------------------------------------------------------------------------------------------------------------------\n")
  end

end

return Controllers