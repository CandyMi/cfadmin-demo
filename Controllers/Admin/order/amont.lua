local admin = {}

admin.use_path = "/admin/order/amount"
function admin.use_route(ctx, db)
  return "/admin/order/amount"
end

admin.api_path = "/api/admin/order/amount"
function admin.api_route(ctx, db)
  return '{"msg":"/api/admin/order/amount"}'
end

return admin