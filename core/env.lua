-- saving from Lua5.2+ API breakage

_G = _G or _ENV or {}
_ENV = _ENV or _G

function _ENV.string.fmt (str,format)
        local str=tostring(str);
        local format=tostring(format);
        return format:format(str)
end;

function _ENV.print_r (t, indent) --Not by me
    local indent=indent or ''
    for key,value in pairs(t) do
        io.write(indent,'[',tostring(key),']')
        if type(value)=="table" then io.write(':\n') print_r(value,indent..'\t')
        else io.write(' = ',tostring(value),'\n') end
    end
end

local handler = {}

local function term2hex(color)
  local color = color;
  if type(color) ~= "number" then
    if type(color) == "string" then
        color = tonumber(color);
        local clr = {

        }
    end
  end
end

local function colorize(text, ...)
  local codes = { }
  local res
  for i, code in ipairs{...} do codes[i] = tostring(code) end
  if curse or cli then
      if
    res = "\027[" .. table.concat(codes, ";") .. "m" .. text .. "\027[0m"
  elseif ngx then
    res = ""
  end
  return res
end

local function handler.value(pos, value)
  local tvalue = type(value)
  if tvalue == "table" and shell.value.prettyprint_tables then
    -- if table has a __tostring metamethod, then use it
    local mt = getmetatable(value)
    if mt and mt.__tostring and shell.value.table_use_tostring then
      value = tostring(value)
    else
      -- otherwise pretty-print it
      -- TODO: make a custom pretty print function: short tables on a single line,
      -- clearer indentation, ...
      value = pretty.write(value)
    end
  else -- fall back to default tostring
    value = tostring(value)
  end
  return colorize("["..pos.."]", 1, 30) .. " "..value
end


function shell.onerror.handler(err)
  local buffer = { colorize(tostring(err), 31), "Stack traceback:" }
  local tmpl   = "  At %s:%d (in %s %s)"
  -- index in buffer of last xpcall call in stack, it will be used to strip ILuaJIT
  -- internal functions of the error traceback.
  local lastxpcall = 0
  for i=2, math.huge do
    local info = debug.getinfo(i)
    if not info then break end
    if info.func == xpcall then lastxpcall = #buffer end
    buffer[#buffer+1] = tmpl:format(info.source, info.currentline or -1, info.namewhat, info.name or "?")
    if shell.onerror.print_code and (info.what == "Lua" or info.what == "main") and info.currentline then
      local file
      if src_history[info.source]     then file = stringio.open(src_history[info.source])
      elseif info.source:match("^@")  then file = io.open(info.source:sub(2), "r") end
      if file then
        buffer[#buffer+1] = highlight_line(file, info.currentline, shell.onerror.area)
      end
    end
  end
  return table.concat(buffer, "\n", 1, lastxpcall)
end


function shell.try(cmd)
  local chunkname = "stdin#"..shell.input_sequence
  local func = assert(loadstring(cmd, chunkname))
  shell.input_sequence = shell.input_sequence + 1
  src_history[chunkname] = cmd
  return shell.result_handler(xpcall(func, shell.onerror.handler))
end

function shell.result_handler(success, ...)
  if success then
    local buf = { }
    for i=1, select("#", ...) do
      buf[i] = shell.value.handler(i, select(i, ...))
    end
    return table.concat(buf, shell.value.separator)
  end
  -- error
  return (...)
end

return _ENV