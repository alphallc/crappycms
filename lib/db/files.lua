if not app.files_db then error("files database not configured!") end
local path = app.files_db.path;

local db = {};

function db:store(data,file)
    local scratch = file.."~";
    local f, ok, msg;
    repeat
        f, msg = io.open(scratch, "w");
        if not f then break end

        ok, msg = f:write(data);
        if not ok then break end

        ok, msg = f:close();
        if not ok then break end

        return os.rename(scratch, file);
    until false;

    -- Cleanup
    if f then f:close(); end
    os.remove(scratch);
    return nil, msg;
end

function db:load(key,file)
	local arr = loadfile(file, nil, _E);
	return arr.key;
end

return db;
