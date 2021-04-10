if not app.pg_loc then error("ngx_postgres database base location not configured!") end
local path = app.pg_loc;

local db = {};

function db:q(key,meta)
	local meta = meta or {};
	local ok=true;
	local key = key:gsub(':','/');
	local arr = ngx.location.capture(path..key, meta);
	if arr.status ~= ngx.HTTP_OK then
		error(("truncated: %s\nstatus: %s\nheaders: %s\nbody: %s"):format(arr.truncated,arr.status,arr.header,arr.body));
		ok=false;
	end
	return ok, ok and json.decode(arr.body) or arr.status;
end

function db:store(key,args)
	local meta = {};
	meta.args = args;
	meta.method=ngx.HTTP_POST;
	return db:q(key,meta)
end

function db:load(key,args)
	local meta = {};
	meta.args = args;
	meta.method=ngx.HTTP_GET;
	return db:q(key,meta)
end

return db;
