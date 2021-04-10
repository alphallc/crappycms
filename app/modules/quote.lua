local _I = {};

function _I.render()
	local cnt, q = {}, {};
	local id = (request.query.id:match("%d+"));
	cnt.title = "iBash.im: Цитата #"..(id or "0");

	if request.query.vote then
		if request.ua:match"[bB]ot" then return end; -- XXX: Временный костыль, пока не переделается инраструктура.
		ngx.location.capture('/vote?id='..id..'&vote='..request.query.vote);
	end
	local db_res = ngx.location.capture('/db/q/single?id='..(id or 0));
    if db_res.status ~= ngx.HTTP_OK then
		cnt.title = "iBash.im: Ошибка";
		cnt.body = '<div class="quote"><div class="error">&lt;iBash&gt; Ошибка соединения с базой данных'
		if app.debug then
			cnt.body = cnt.body .. (":<code>truncated: %s\nstatus: %s\nheaders: %s\nbody: %s</code></div></div>"):format(db_res.truncated,db_res.status,db_res.headers,db_res.body)
		else
			error(("truncated: %s\nstatus: %s\nheaders: %s\nbody: %s"):format(db_res.truncated,db_res.status,db_res.headers,db_res.body));
			cnt.body = cnt.body .. (".<br/>Администратор уже извещён о проблеме. Мы постараемся её исправить в самое ближайшее время.</div></div>")
		end
	else
		local b = db_res.body:gsub("([^\\])\\n","%1<br />");
		q.quote = json.decode(b)[1];
		if not q.quote then
			b = [=[[{"id":0,"rating":999,"body":"&lt;iBash.im&gt; Цитата не найдена! <br /> &lt;mva&gt; НИЧОСИ!","date_added":"1970-01-01 00:00:00","date_approved":"1970-01-01 00:00:00","approvers":"[\"Anonymous\"]"}]]=];
			q.quote = json.decode(b)[1];
		end

		q.quote.approvers = json.decode(is_null(q.quote.approvers,"[]"));
        cnt.body = r("quote",q);
	end
	p(r("page",cnt))

end

return _I
