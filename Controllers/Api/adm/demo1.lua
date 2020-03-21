local api = { path = "/api/demo1" }

function api.route( content )
  return '{"msg":"demo1 route"}'
end

return api