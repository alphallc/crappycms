<hr></hr>
{(q.tpl,{quote=quote})}
<hr></hr>
<div class="quinfo">
	<span>Дата добавления: {{quote.date_added}}</span>
	<span>Дата одобрения: {{is_null(quote.date_approved,"Нет")}}</span>
{%
local s = (#quote.approvers>1) and "ы" or "";
local approvers = table.concat(quote.approvers,", ");
approvers = #approvers>0 and approvers or nil;

if approvers then
%}
	<span>Аппрувер{{s}}: {{approvers}}</span>
{%end%}
</div>
<hr></hr>
