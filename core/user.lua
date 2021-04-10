local _U = T{};

_U.avatar = require"lib.avatar";

_U.info = T{};

function _U.info:get(id)
  local id = tonumber(id) or 0;
  local users = T{
    T{
      id = 1;
      email = "mva@mva.name";
      name = "mva";
      color = "orange";
      profile = "#";
      gender = "male";
      title = "";
      acl = T{
        main = "";
      };
      post_group = "";
      postcount = 500;
      karma = T{
        neg = 10;
        pos = 20;
      };
    },
  }
  return users[rand.number(1,#users)];
end

return _U;
