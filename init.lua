-- hacks
_ENV = require"core.env"
-- /hacks

_G = _G or _ENV or {}

if ngx then
  root = ngx.var.document_root
else
  root = ".";
end

package.path = root.."/?.lua;"..root.."/?/init.lua;"..package.path;
package.cpath = root.."/?.so;"..root.."/?/all.so;"..package.cpath;

app = require"app.config" or {};

--NB: incompatible with utf8 sub from core.string; should be required before it;
template = require"resty.template";

table = require"core.table"
T=table.create;
string = require"core.string"
file = require "core.file"

core = require"core.functions";
db = require"lib.db"
json = require"cjson";
bb = require"lib.bbcode";
md = require"lib.markdown";

if ngx then
  ngx = ngx;
  local n = require"app.nginx";
  n.start();
  ngx.eof();
  ngx.exit(0);
elseif curse then
  local crs = require "ui.curse";
  local res = crs.start();
  os.exit(res);
elseif cli then
  local cli = require"ui.cli";
  local res = cli.start();
  os.exit(res);
end
