<div class="quote">
	<div class="quothead">
		<span>
			<a href="/quote?id={{quote.id}}"><b>#{{quote.id}}</b></a>
		</span>
		<span>
			<a onclick="return vote('{{quote.id}}','plus');" rel="nofollow" href="/quote?id={{quote.id}}&vote=plus">+</a>
			(&nbsp;<span id="q{{quote.id}}" class="rate">{{quote.rating}}</span>&nbsp;)
			<a onclick="return vote('{{quote.id}}','minus');" rel="nofollow" href="/quote?id={{quote.id}}&vote=minus">–</a>
		</span>
{%
	local pub_t={};
    local date_approved = is_null(quote.date_approved, os.date('%Y-%m-%d %H:%M:%S'));
	pub_t.year,pub_t.month,pub_t.day,pub_t.hour,pub_t.min,pub_t.sec = date_approved:match("(%d%d%d%d)-(%d%d)-(%d%d) (%d%d):(%d%d):(%d%d)");
	if os.time(pub_t)+43200 > os.time() then
	-- TODO: cookie; ([quothead])
%}
		<b class="nq">NEW!</b>
{%end%}
	</div>
	<div class="quotbody">{*quote.body*}</div>
</div>
