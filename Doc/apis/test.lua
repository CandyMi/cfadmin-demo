--[[
@apiDefine mytest 测试接口
--]]

--[[
@api {GET | POST} /api/test/list 获取用户列表
@apiName 1
@apiDescription 获取用户列表
@apiVersion 0.0.1
@apiGroup mytest

@apiParam {Integer} page 列表页数
@apiParam {Integer} size 每页数量

@apiSuccess (返回值) {Integer} code  返回状态码
@apiSuccess (返回值) {String}  msg   返回信息
@apiSuccess (返回值) {Object}  data  数据结构体
@apiSuccess (返回值) {Integer}    data.page   page参数
@apiSuccess (返回值) {Integer}    data.size   size参数
@apiSuccess (返回值) {Integer}    data.count  用户总数
@apiSuccess (返回值) {Object[]}   data.items[]  用户列表
@apiSuccess (返回值) {String}      data.items.nickname  用户昵称
@apiSuccess (返回值) {String}      data.items.avatar    用户头像
@apiSuccess (返回值) {Integer}     data.items.age       用户年龄

@apiSuccessExample {json} 成功 - 200
HTTP/1.1 200 OK
{
  "code": 200,
  "msg": "请求成功",
  "data": {
    "page": 1,
    "size": 10,
    "count": "1",
    "items":[
      {
        "uid":1,
        "nickname": "水果糖的小铺子",
        "avatar"  : "http://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83eowoIHibd9KuXCLlL5LuAJA4GkvBzAr2ibMyo5It7UaxlibAe8ChvVwEZEBEWfibplOsc1ETqhbNsbC6A/132",
        "age":30
      }
    ]
}

@apiErrorExample {json} 失败 - 400
HTTP/1.1 200 OK
{
  "code": 400,
  "msg": "无效的请求参数"
}

@apiErrorExample {json} 失败 - 500
HTTP/1.1 200 OK
{
  "code": 500,
  "msg": "服务器内部错误"
}
--]]


--[[
@api {GET | POST} /api/test/user_info 获取用户详情
@apiName 2
@apiDescription 获取用户详情
@apiVersion 0.0.1
@apiGroup mytest

@apiParam {Integer} uid 用户ID

@apiSuccess (返回值) {Integer}  code  返回状态码
@apiSuccess (返回值) {String}   msg   返回信息
@apiSuccess (返回值) {Object}   data  数据结构体
@apiSuccess (返回值) {Integer}  data.nickname  用户头像
@apiSuccess (返回值) {String}   data.avatar    用户昵称
@apiSuccess (返回值) {Integer}  data.age       用户年龄

@apiSuccessExample {json} 成功 - 200
HTTP/1.1 200 OK
{
  "code": 200,
  "msg": "请求成功",
  "data": {
    "nickname": "水果糖的小铺子",
    "avatar"  : "http://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83eowoIHibd9KuXCLlL5LuAJA4GkvBzAr2ibMyo5It7UaxlibAe8ChvVwEZEBEWfibplOsc1ETqhbNsbC6A/132",
    "age":30
  }
}

@apiErrorExample {json} 失败 - 400
HTTP/1.1 200 OK
{
  "code": 400,
  "msg": "无效的请求参数"
}

@apiErrorExample {json} 失败 - 404
HTTP/1.1 200 OK
{
  "code": 404,
  "msg": "找不到此用户"
}

@apiErrorExample {json} 失败 - 500
HTTP/1.1 200 OK
{
  "code": 500,
  "msg": "服务器内部错误"
}
--]]