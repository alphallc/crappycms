local _S = {};

function _S:get(sid)
  local sess = {}
  --TODO: get info from db and redis and cache it;
  sess.id = sid or uuid(ngx.md5(request.ip.addr..(request.os.name or "unknown")..(request.browser.name or "unknown")));

  sess.logged_in = true
  sess.user = {}
  sess.user.name = "mva";
  return sess
end

return _S;
