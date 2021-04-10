

function encode(x)
	local bytes = {}
	local xmod
	x, xmod = math.modf(x/255)
	xmod = xmod * 255
	bytes[#bytes + 1] = xmod
	while x > 0 do
		x, xmod = math.modf(x/255)
		xmod = xmod * 255
		bytes[#bytes + 1] = xmod
	end
	if #bytes == 1 and bytes[1] > 0 and bytes[1] < 249 then
		return string.char(bytes[1])
	else
		for i = 1, #bytes do bytes[i] = bytes[i] + 1 end
		return string.char(256 - #bytes, unpack(bytes))
	end
end

--decode converts a unique character sequence into its equivalent number, from ss, beginning at the ith char.
-- returns the decoded number and the count of characters used in the decode process.
function decode(ss,i)
	i = i or 1
	local a = string.byte(ss,i,i)
	if a > 249 then
		local r = 0
		a = 256 - a
		for n = i+a, i+1, -1 do
			r = r * 256 + string.byte(ss,n,n) - 1
		end
		return r, a + 1
	else
		return a, 1
	end
end


-- Compresses the given uncompressed string.
-- Unless the uncompressed string starts with "\002", this is guaranteed to return a string equal to or smaller than
-- the passed string.
-- the returned string will only contain "\000" characters in rare circumstances, and will contain none if the
-- source string has none.
local dict = {}
function CompressLZW(uncompressed)
	if type(uncompressed) == "string" then
		local dict_size = 256
		for k in pairs(dict) do
			dict[k] = nil
		end
		local result = {"\002"}
		local w = ''
		local ressize = 1
		for i = 0, 255 do
			dict[string.char(i)] = i
		end
		for i = 1, #uncompressed do
			local c = uncompressed:sub(i,i)
			local wc = w..c
			if dict[wc] then
				w = wc
			else
				dict[wc] = dict_size
				dict_size = dict_size +1
				local r = encode(dict[w])
				ressize = ressize + #r
				result[#result + 1] = r
				w = c
			end
		end
		if w then
			local r = encode(dict[w])
			ressize = ressize + #r
			result[#result + 1] = r
		end
		if (#uncompressed+1) > ressize then
			return table.concat(result)
		else
			return string.char(1)..uncompressed
		end
	else
		return nil, "Can only compress strings"
	end
end

-- if the passed string is a compressed string, this will decompress it and return the decompressed string.
-- Otherwise it return an error message
-- compressed strings are marked by beginning with "\002"
function DecompressLZW(compressed)
	if type(compressed) == "string" then
		if compressed:sub(1,1) ~= "\002" then
			return nil, "Can only decompress LZW compressed data ("..tostring(compressed:sub(1,1))..")"
		end
		compressed = compressed:sub(2)
		local dict_size = 256
		for k in pairs(dict) do
			dict[k] = nil
		end
		for i = 0, 255 do
			dict[i] = string.char(i)
		end
		local result = {}
		local t = 1
		local delta, k
		k, delta = decode(compressed,t)
		t = t + delta
		result[#result+1] = dict[k]
		local w = dict[k]
		local entry
		while t <= #compressed do
			k, delta = decode(compressed,t)
			t = t + delta
			entry = dict[k] or (w..w:sub(1,1))
			result[#result+1] = entry
			dict[dict_size] = w..entry:sub(1,1)
			dict_size = dict_size + 1
			w = entry
		end
		return table.concat(result)
	else
		return nil, "Can only uncompress strings"
	end
end
