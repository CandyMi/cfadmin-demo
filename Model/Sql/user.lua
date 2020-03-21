local model = require "Model"

local fmt = string.format

local user = { }

function user.find_user_info(id)
  return model.query(fmt([[SELECT * FROM cfadmin_user where id = %d LIMIT 1]], id))
end

return user