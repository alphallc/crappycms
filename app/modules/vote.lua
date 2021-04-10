local _I = {};

function _I.render()
	local rating;
	if request.query.id and request.query.vote then
		if not (request.query.vote == "plus" or request.query.vote == "minus") then
			request.query.vote="plus"; -- kludge! ;)
		end
		local db_res = ngx.location.capture('/db/q/vote?vote='..request.query.vote..'&id='..request.query.id);
		if db_res.status ~= ngx.HTTP_OK then
			error(("truncated: %s\nstatus: %s\nheaders: %s\nbody: %s"):format(db_res.truncated,db_res.status,db_res.headers,db_res.body));
			ngx.status = ngx.HTTP_NOT_FOUND;
			ngx.exit(ngx.HTTP_NOT_FOUND);
		else
			local b = db_res.body;
			if not b then return end;
			rating = json.decode(b)[1].rating;
		end
	end
	pn("q"..(tostring(tonumber(request.query.id)) or "").."="..(tostring(tonumber(rating)) or ""));
end

return _I
