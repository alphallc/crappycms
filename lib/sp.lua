local _M = { }

function _M:get_sp_status(id)
	local statuses = {
		{title="start", descr="Начинается"},
		{title="fix", descr="Фиксация заказов с"},
		{title="stop", descr="Стоп"},
		{title="add", descr="Дозаказ до"},
		{title="bill", descr="Счёт получен"},
		{title="pay", descr="Оплата до"},
		{title="ship", descr="В пути с"},
		{title="sort", descr="Сортировка с"},
		{title="take", descr="Раздача с"},
		{title="end", descr="Завершена"},
	}
	local purch_st = statuses[rand.number(1,#statuses)];
	purch_st.descr = purch_st.descr.." "
		..tostring(rand.number(1,30)).."/"
		..tostring(rand.number(1,12)).."/"
		..tostring(rand.number(os.date("%Y"),os.date("%Y")+20));

	return purch_st;
end


return _M
