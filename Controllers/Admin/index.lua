local admin = {}



admin.use_path = "/admin/index"
function admin.use_route(db, ctx)
  return "/admin/index"
end



admin.api_path = "/api/admin/index"
function admin.api_route(db, ctx)
  return '{"msg":"/admin/index"}'
end


return admin