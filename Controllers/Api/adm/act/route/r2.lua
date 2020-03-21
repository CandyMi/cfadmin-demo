local api = { path = "/api/r2" }

function api.route( content )
  return '{"msg":"r2 route"}'
end

return api