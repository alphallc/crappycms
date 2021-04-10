<div class="add">
	<div class="addbody">
		{% if added then %}
			Цитата отправлена на рассмотрение. Возможно, в ближайшее время она появится на сайте.
		{% else %}
		<div style="width: 100%;">
		<form action="/add" method="post"><fieldset>
			<textarea name="quote" rows="24" cols="80"></textarea><br />
			<input value="Отправить на рассмотрение" type="submit">
		</fieldset></form>
		</div>
		{% end %}
	</div>
</div>
