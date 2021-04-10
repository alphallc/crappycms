local _I = {};

function _I.render()
	local cnt = {};
	cnt.title = "iBash.im шкурки";
		cnt.body = r("skins");
		p(r("page",cnt))
end

return _I
