local api = { path = "/api/action1" }

function api.route( content )
  return '{"msg":"action1 route"}'
end

return api