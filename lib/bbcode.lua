#!/usr/bin/env lua

local T = function(...) return ...; end;
--require"core.l10n".init("bbcode")
local _M = {}


local function nocase(s)
s = string.gsub(s, "%a", function (c)
	return string.format("[%s%s]", string.lower(c), string.upper(c))
end)
return s
end

local function safe(str)
	return tostring(str or "");
end

function _M.to_html(text)
local tags = {
	i = function(_,text)
		return "<i>"..safe(text).."</i>";
	end,

	u = function(_,text)
		return "<u>"..safe(text).."</u>"
	end,

	b = function(_,text)
		return "<b>"..safe(text).."</b>"
	end,

	s = function(_,text)
		return "<s>"..safe(text).."</s>"
	end,

	sup = function(_,text)
		return "<sup>"..safe(text).."</sup>"
	end,

	sub = function(_,text)
		return "<sub>"..safe(text).."</sub>"
	end,

	pre = function(_,text)
		return "<pre>"..safe(text).."</pre>"
	end,

	code = function(_,text)
		return "<code>"..safe(text).."</code>"
	end,

	h1 = function(_,text)
		return "<h1>"..safe(text).."</h1>"
	end,

	h2 = function(_,text)
		return "<h2>"..safe(text).."</h2>"
	end,

	h3 = function(_,text)
		return "<h3>"..safe(text).."</h3>"
	end,

	h4 = function(_,text)
		return "<h4>"..safe(text).."</h4>"
	end,

	h5 = function(_,text)
		return "<h5>"..safe(text).."</h5>"
	end,

	h6 = function(_,text)
		return "<h6>"..safe(text).."</h6>"
	end,

	table = function(_,body)
		return "<table>"..safe(body).."</table>"
	end,

	thead = function(_,body)
		return "<thead>"..safe(body).."</thead>"
	end,

	tbody = function(_,body)
		return "<tbody>"..safe(body).."</tbody>"
	end,

	th = function(_,body)
		return "<th>"..safe(body).."</th>"
	end,

	tr = function(_,body)
		return "<tr>"..safe(body).."</tr>"
	end,

	td = function(_,body)
		return "<td>"..safe(body).."</td>"
	end,

	hr = function()
		return "<hr />"
	end,

	center = function(_,text)
		return [=[<span style="text-align: center;">]=]..safe(text)..[=[</span>]=]
	end,

	font = function(name,text)
		return [=[<span style="font-family: ]=]..safe(name)..[=[;">]=]..safe(text)..[=[</span>]=]
	end,

	size = function(size,text)
		local sizes = {
			micro = "xx-small",
			mini = "x-small",
			small = "smal",
			medium = "medium",
			large = "large",
			big = "x-large",
			giant = "xx-large",
		}
		return [=[<span style="font-size: ]=]..safe(sizes.size or "100%")..[=[;">]=]..safe(text)..[=[</span>]=]
	end,

	color = function(color,text)
		return [=[<span style="color: ]=]..safe(color or "none")..[=[;">]=]..safe(text)..[=[</span>]=]
	end,

	quote = function(param,text)
		 local nick, msg_id = param:match("([^;]*);?(%d*)");
		return [=[<blockquote class="msg_quote"><cite class="quoteheader"><div class="topslice_quote">]=]..
				(#msg_id>0 and [=[<a href="#]=]..msg_id..[=[">]=] or "")..
				(#nick>0 and nick..[=[ пишет:]=] or "Цитата:")..
				(#msg_id>0 and "</a>" or "")..
				[=[</div></cite>]=]..
				safe(text)..[=[<br><cite class="quotefooter"></cite></blockquote>]=]
	end,

	url = function(href,text)
		return [=[<a href="]=]..safe(href)..[=[">]=]..safe(text)..[=[</a>]=]
	end,

	img = function(src,alt)
		if (#src == 0) and (#alt > 0) then
			src = alt;
			alt = "Картинка";
		elseif (#src == 0) and (#alt == 0) then
			return "";
		end
		return [=[<img src="]=]..safe(src)..[=[" alt="]=]..alt..[=[" title="]=]..alt..[=[" />]=]
	end,
}

	for t,f in pairs(tags) do
		t = nocase(t);
		while text:match("%["..t.."=?[^]]*%].-%[/"..t.."%]") do
		text = text:gsub("%["..t.."=?['\"]?([^'\"%]]*)['\"]?%](.-)%[/"..t.."%]",f)
		end
	end
	return text
end

return _M;
