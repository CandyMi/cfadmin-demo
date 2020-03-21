local api = { path = "/api/test1/test1" }

function api.route( content )
  return '{"msg":"test1 Route"}'
end

return api