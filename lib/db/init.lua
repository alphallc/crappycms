if not app.db then error("database is not configured!") end
local engine_n = app.db;
local engine_t;
local ok, res = pcall(require,"lib.db."..engine_n)
if ok then
	engine_t = res;
else
	error(("DB::Init, res: %s"):format(res));
end

return engine_t;
