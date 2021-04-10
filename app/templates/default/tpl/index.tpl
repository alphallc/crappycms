{%
for _,quote in ipairs(quotes) do
%}
{(q.tpl,{quote=quote})}
{%end%}
{%
local p = math.floor(tonumber(total_quotes)/50);
if p>0 then
local function page_link(page)
	local page=tonumber(page);
	local rpage=tonumber(request.query.page or 0)
	local mod=tostring(request.req_module);
	mod=mod:gsub("%.","/");
	mod=mod:gsub("_",".");
	mod=mod:gsub("index","");
	if page == rpage then
		result=page;
	else
		result=[[<a href="/]]..mod..(page>0 and [[?page=]]..page or [[]])..[[">]]..page..[[</a>]]
	end
	return tostring(result)
end

	local pages = page_link(0);
	for page=1,p do
		pages=pages.." "..page_link(page);
	end;
%}
<nav id="pages">
	Страницы: {*pages*}
</nav>
{% end %}
