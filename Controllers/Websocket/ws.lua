local class = require "class"


local Websocket = class("Websocket")

function Websocket:ctor(opt)
  -- init
  print("初始化Wesocket对象")
end

function Websocket:on_open(...)
  -- when connected
  print("连接成功")
end

function Websocket:on_message(data, types)
  -- when message comming
  print("收到消息: [" .. data .. "]")
end

function Websocket:on_error(err)
  -- when error happen
  print("发生错误: [" .. err .. "]")
end

function Websocket:on_close(data)
  -- when closed
  print("关闭连接: [" .. (data or "") .. "]")
end

return Websocket