local _I = {};

function _I.render()
	local cnt = {};
	cnt.title = "iBash: Прислать новую цитату";

	if (request.method == "POST" and request.query.quote) then
		local db_res = ngx.location.capture('/db/q/add?quote='..request.query.quote);
		if db_res.status ~= ngx.HTTP_OK then
			error(("truncated: %s\nstatus: %s\nheaders: %s\nbody: %s"):format(db_res.truncated,db_res.status,db_res.headers,db_res.body));
			ngx.status = ngx.HTTP_INTERNAL_SERVER_ERROR;
			ngx.exit(ngx.HTTP_INTERNAL_SERVER_ERROR);
		else
			cnt.added=true;
		end
	end
	cnt.body = r("add",cnt);
	p(r("page",cnt))
end

return _I
