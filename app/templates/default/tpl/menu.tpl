{%
local name={
	"index",
	"best",
	"random",
	"add",
	"search",
	"skins",
	"trash",
	"abyss",
	"rss_xml",
--	"forum"
}
name.index="По дате";
name.best="По рейтингу";
name.random="Случайно";
name.add="Добавить цитату";
name.search="Поиск";
name.skins="Шкурки";
name.rss_xml="RSS";
--name.forum="Форум";
name.trash="😞";
name.abyss="😷";

local function menu_link(module)
	local mod;
--	mod=module:gsub("%.","/");
	mod=module:gsub("_",".");
	mod=mod:gsub("index","");
	local function comm(str)
		if mod=="trash" or mod=="abyss" then
			return [[<!--]]..str..[[-->]];
		else
			return str;
		end
	end
	if not request.req_module:match(module) then
		result=comm([=[[&nbsp;<a href="/]=]..mod..[[">]]..name[module]..[=[</a>&nbsp;]]=]);
	else
		result=[=[[&nbsp;]=]..name[module]..[=[&nbsp;]]=];
	end
	return tostring(result)
end
%}
<nav id="menu">
{%
	local menu;
	for _,cat in ipairs(name) do menu=(menu and menu.." " or "")..menu_link(cat) end;
%}
{*menu*}
</nav>
