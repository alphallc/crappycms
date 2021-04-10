local _I = {};

function _I.render()
	local cnt, q = {}, {};
	cnt.title = "iBash.im: Кто ищет, тот всегда найдёт";

	if (request.method == "POST" and request.query.q) then
		local db_res = ngx.location.capture('/db/q/search?q='..request.query.q);
		if db_res.status ~= ngx.HTTP_OK then
			cnt.title = "iBash.im: Ошибка";
			cnt.body = '<div class="quote"><div class="error">&ltiBash;&gt; Ошибка соединения с базой данных'
			if app.debug then
				cnt.body = cnt.body .. (":<code>truncated: %s\nstatus: %s\nheaders: %s\nbody: %s</code></div></div>"):format(db_res.truncated,db_res.status,db_res.headers,db_res.body)
			else
				error(("truncated: %s\nstatus: %s\nheaders: %s\nbody: %s"):format(db_res.truncated,db_res.status,db_res.headers,db_res.body));
				cnt.body = cnt.body .. (".<br/>Администратор уже извещён о проблеме. Мы постараемся её исправить в самое ближайшее время.</div></div>")
			end
		else
			local b = db_res.body:gsub("([^\\])\\n","%1<br />");
			q.quote = json.decode(b)[1];
			cnt.body = r("search",q);
		end
	else
	cnt.body = r("search",q);
	end
	p(r("page",cnt))
end

return _I
