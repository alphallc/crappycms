require"resty.core"; -- JIT'ify Lua Module!

re = ngx.re;
p = ngx.say;
pn = ngx.print;

app = app or require"app.config";

theme = app.theme or "default";
tpl_root = app.template_root or ngx.var.document_root.."/app/templates/"..theme.."/tpl";

ngx.var.template_root = tpl_root;

core = require"core.functions";
template = require"resty.template";
tpl = require"core.template";

cookie = require"resty.cookie":new();
user = require"core.user";
request = require"core.request";
json = require"cjson";
rds = require"rds.parser";
rand = require"resty.random";
forum = require"lib.forum";
db = require"lib.db" -- db engine was rewriten, but I didn't test it yet. TODO: test

r = tpl.render_tpl;
s = tpl.render_svg;

bb = require"lib.bbcode";
md = require"lib.markdown";

error = function(...) ngx.log(ngx.ERR, ...) end;
log = function(...) ngx.log(ngx.STDERR, ...) end;
notice = function(...) ngx.log(ngx.NOTICE, ...) end;
info = function(...) ngx.log(ngx.INFO, ...) end;
emergency = function(...) ngx.log(ngx.EMERG, ...) end;
alert = function(...) ngx.log(ngx.ALERT, ...) end;
critical = function(...) ngx.log(ngx.CRIT, ...) end;
warning = function(...) ngx.log(ngx.WARN, ...) end;
debug = function(...) ngx.log(ngx.DEBUG, ...) end;

function is_null(c,ret)
  local res = not(not(c==nil or c==ngx.null))
  return (ret and (res and ret or c) or res);
end

ngx.header.Content_Type = 'text/html; charset=utf-8';
ngx.header.X_Info = 'This site is currently under heavy development';
ngx.header.Server = '';

local _N = {}

function _N.start()

--(ngx.var.document_uri or "/"):gsub("[./]", {["%."] = "_",["/"] = "."});
--if mod == "." then mod = ".index" end;
--mod = mod:gsub("^%.","");


local ok, res = pcall(require,"www.modules."..request.req_module);
  if ok then
    res.render();
  else
	if res:match("module .* not found") then
		ngx.status = ngx.HTTP_NOT_FOUND;
		ngx.exit(ngx.HTTP_NOT_FOUND);
	else
		ngx.status = ngx.HTTP_METHOD_NOT_IMPLEMENTED;
		local cnt = {};
		cnt.title = "iBash — Ошибка";
		cnt.body = ('<div class="error">Модуль %s%s содержит ошибку'):format(app.name,user.req_module)
		if app.debug then
			cnt.body = cnt.body .. (":<code>%s</code></div>"):format(res)
		else
			error(res);
			cnt.body = cnt.body .. (".<br/>Администратор уже извещён о проблеме. Мы постараемся её исправить в самое ближайшее время.</div>")
		end
		p(r("page",cnt))
	end
  end;
end;

return _N
