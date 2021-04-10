local _I = {};

function _I.render()
	local cnt, q = {}, {};
	local page;
	page = request.query.page;
	cnt.title = "iBash.im: Лучшее";

	local db_res = ngx.location.capture('/db/q/best?page='..(page or 0));
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
		q.total_quotes = json.decode(ngx.location.capture("/db/q/count").body)[1].count;
		q.quotes = json.decode(b);
		cnt.body = r("index",q);
		cnt.q = #(q.quotes or {})
	end

	p(r("page",cnt))
end

return _I
