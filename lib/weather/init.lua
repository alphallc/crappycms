local _W = {}

function _W.get_season()
  local m = tonumber(os.date("%m"));
  local season = "";
  if (m < 3 or m > 11) then
    season = "winter";
  elseif (m >= 3 and m < 6) then
    season = "spring";
  elseif (m >= 6 and m < 9) then
    season = "summer";
  else
    season = "autumn";
  end
  return season;
end

function _W:get_meta()
	local meta = {};
	meta = {
		hum = 80;
		temp = 20;
		wind_speed = 5;
		press = 760;
		wind = "w";
		sun = "r";
	}
	return meta;
end

function _W:render_temp(meta)
	return meta.temp.."°C"
end

function _W:render_windspeed(meta)
	return meta.wind_speed.."м/с"
end

function _W:render_press(meta)
	return meta.press.."🌡"
end

function _W:render_hum(meta)
	return meta.hum.."%"
end

function _W:render_wind(meta)
	local wind_map = {};
	wind_map = {
		n = { img = "↓", title="Северный"},
		ne = { img = "↙", title="Северо-Восточный"},
		e = { img = "←", title="Восточный"},
		se = { img = "↖", title="Юго-Восточный"},
		s = { img = "↑", title="Южный"},
		sw = { img = "↗", title="Юго-Западный" },
		w = { img = "→", title="Западный" },
		nw = { img = "↘", title="Северо-Западный" },
	}

	return wind_map[meta.wind]
end

function _W:render_sun(meta)
	local sun_map = {}
	sun_map = {
		s = {img = "☀", title = "День; Ясно", color="gold"},
		mn = {img= "☽", title = "Ночь; Ясно; Растущая луна", color = "default"},
		mo = {img = "☾", title = "Ночь; Ясно; Убывающая луна", color = "default"},
		c = {img = "☁", title = "Облачно", color="default"},
		r = {img = "☔", title = "Дождь", color="blue"},
		sn = {img = "❅", title = "Снегопад", color="blue"},
		l = {img = "⚡", title = "Гроза", color= "yellow"},
		mt = {img = "☄", title="Метеоритный дождь", color = "orange"},
	}

	return sun_map[meta.sun]
end

return _W;
