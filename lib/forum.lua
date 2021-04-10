local _M = { }

function _M:read_status(theme_id,user_id)
	local statuses = { "read", "unread", "new", "replied" };
	return statuses[rand.number(1,4)];
end

return _M
