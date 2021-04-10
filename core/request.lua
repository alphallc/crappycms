local _R = T{}

local OSes = T{
  android = "Android ",
  linux = "Linux",
  freebsd = "FreeBSD",
  windows = "Windows",
  mac = "Mac[ _]OS[ _]X",
}
local BROWSERS = T{
  opera = "Opera/([^% ]+).*Presto",
  new_opera = "OPR/([^% ]+)",
  chrome = "Chrome/([^% ]+)",
  leechcraft = "Leech[Cc]raft/([^% ]+)",
  ie = "MSIE (([^%;]+))",
  rekonq = "rekonq/([^% ]+)",
  konqueror = "konqueror/([^% ]+)",
  safari = "Version/([^% ]+).*Safari",
  firefox = "Firefox/([^% ]+)",
  iphone = "iPhone.*OS ([^% ]+).*Safari",
  ipad = "iPad.*OS ([^% ]+).*Safari"
}

_R.os, _R.browser, _R.country, _R.ip = T{}, T{}, T{}, T{};
_R.referrer = ngx.var.http_referrer;
_R.ip.addr = tostring(ngx.var.remote_addr);
if _R.ip.addr:find("%:%x") or _R.ip.addr:find("%x%:") then
	_R.ip.family = "ipv6"
elseif _R.ip.addr:find("%d%.%d") then
	_R.ip.family = "ipv4"
else
	_R.ip.family = "unknown"
end
_R.ua = ngx.var.http_user_agent or "unknown";
_R.country.name = ngx.var.country;
_R.method = ngx.req.get_method();

_R.req_params = T{};
_R.query = T{};
for s in (ngx.var.document_uri or "/"):gmatch('([^/]+)/?') do
	_R.req_params[#_R.req_params+1] = s:gsub("%.","_");
end

_R.req_module = (#_R.req_params>0) and _R.req_params:remove(1) or "index";

if _R.method == "GET" or _R.method == "HEAD" then
  _R.query = T(ngx.req.get_uri_args());
elseif _R.method == "POST" or _R.method == "PUT" then
  ngx.req.read_body();
  _R.query = T(ngx.req.get_post_args());
else
  _R.query = "unknown request method: " .. _R.method;
end

for name,pattern in pairs(OSes) do
  if _R.ua:match(pattern) then
    _R.os.name = name;
  end
end

for name,pattern in pairs(BROWSERS) do
  if _R.ua:match(pattern) then
    _R.browser.name = name;
	_R.browser.version = _R.ua:match(pattern)
	_R.browser.webkit_version = _R.ua:match("AppleWebkit/([%d.]+)")
  end
end

return _R
