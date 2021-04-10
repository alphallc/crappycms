local _I = {};

function _I.render()
	local q = {};

	local db_res = ngx.location.capture('/db/q/last?page=0');
	if db_res.status ~= ngx.HTTP_OK then
		error(("truncated: %s\nstatus: %s\nheaders: %s\nbody: %s"):format(db_res.truncated,db_res.status,db_res.headers,db_res.body));
		ngx.status = ngx.HTTP_NOT_FOUND;
		ngx.exit(ngx.HTTP_NOT_FOUND);
	else
		local b = db_res.body:gsub("([^\\])\\n","%1<br />");
		q.quotes = json.decode(b);
		p(r("rss",q))
	end
end

return _I
