<div class="search">
	<div class="searchbody">
		<div style="width: 100%;">
			<form action="/search" method="post"><fieldset>
				<input name="q" maxlength="100" class="inp" value="{{request.query.q or ''}}" type="text">
				<input value=" Найти! " type="submit">
			</fieldset></form>
		</div>
	</div>
</div>
{% if quote then %}
{(q.tpl,{quote=quote})}
{% end %}
