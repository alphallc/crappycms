local _A = {};

function _A:get(user,size)
	local hash = ngx.md5(user.email);
	local size = size or "150";
	local default = "identicon";
	local alt = "Аватар пользователя "..((user and user.name) and user.name or "Аноним")

	return [[<img class="avatar" src="//gravatar.com/avatar/]]..hash..[[?s=]]
		..size..[[&r=g&d=mm&default=]]..default..[[&fn=]]..user.name
		..[[_avatar.png" title="]]..alt..[[" alt="]]..alt..[[">]]
end

return _A
