local string = string;


function string.insert(where,what,pos)
  local where = where or "";
  local what = what or "";
  local pos = pos or 1;
  local res = "";

  if type(pos) == "number" then
    res = where:sub(1,pos-1)..what..where:sub(pos)
  elseif type(pos) == "table" then
    local res_t = T{};
    local prev_pos = 1;
    for _,p in ipairs(pos) do
      local p_type = type(p)
      assert(p_type=="number","You've provided table as position argument, but "..
        "this table contains "..(p_type).." at position "..(_)..", while only numbers are supported");
      res_t:insert(where:sub(prev_pos,p-1));
      prev_pos = p;
    end
    if #pos==0 then res_t:insert("") end;
    res_t:insert(where:sub(pos[#pos] or 0,#where));
    res=res_t:concat(what);
  else
    error("Only number or table of numbers supported as position argument")
  end
  return res;
end

function string.symbol(string,symbol)
  local str = tostring(str);
  local symbol = tonumber(symbol);
  return string:sub(symbol,symbol);
end;

function string.print(string)
  print(string);
end;

function string.word(str,pos)
  local str = tostring(str);
  local pos = tonumber(pos) or 1;
  return str:match(("%S+ "):rep(pos-1).."(%S+)")
end;

function string.fmt(str,format)
  local str=tostring(str);
  local format=tostring(format);
  return format:format(str)
end;

-- PHP's explode
function string.explode(str, sep, limit)
    if not str then return false end
    if not sep or sep == "" then return false end
    local limit = limit or math.huge;
    if limit == 0 or limit == 1 then return T{str} end

    local r = T{}
    local n, init = 0, 1

    while true do
        local s,e = str:find(sep, init, true)
        if not s then break end
        r[#r+1] = str:sub(init, s - 1)
        init = e + 1
        n = n + 1
        if n == limit - 1 then break end
    end

    if init <= str:len() then
        r:insert(str:sub(init))
    else
        r:insert("")
    end
    n = n + 1

    if limit < 0 then
        for i=n, n + limit + 1, -1 do r[i] = nil end
        n = n + limit
    end

    return r
end

-- Python's split
function string.split(str, sep, limit)
    assert(sep ~= "");
    assert(limit == nil or limit >= 1);
    local sep = sep or " ";
    local limit = limit or math.huge;
    if limit == 0 then return {str} end
    if limit < 0 then return str:explode(sep or " ") end

    return str:explode(sep,limit+1);
end

-- Numeric Conversions --

function string.to_bin(s)
    local s = tonumber(s);
    if not s then return nil; end;
    local out = '';

    while s >= 1 do
        if (s%2 ~= 0) then
            out = "1"..out;
        else
            out = "0"..out;
        end;
        s = math.floor(s/2);
    end;
    return out;
end;

function string.to_rbin(s)
    local s = tonumber(s);
    if not s then return nil; end;
    local out = '';

    while s >= 1 do
        if (s%2 ~= 0) then
            out = out.."1"
        else
            out = out.."0";
        end;
        s = math.floor(s/2);
    end;
    return out;
end;

function string.to_hex(s)
  local s = tonumber(s);
  return ("%2X"):format(s)
end;

return string;
