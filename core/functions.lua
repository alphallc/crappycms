
local _C = {}

function _C.obscure(str,t)
	local str=tostring(str);
	local t=(t and tostring(t) or "html")
	local ret="";
	local pref, suf = "", "";

	if t=="url" then
		pref="%";
		suf="";
	elseif t=="html" then
		pref="&x";
		suf = ";";
	else
		pref="";
		suf="";
	end

	for b = 1,#str do
		ret=ret..pref..("%x"):format(str:byte(b))..suf;
	end;
	return ret;
end

--function _C:email(str)
--	return "mailto:"
--end

return _C;
