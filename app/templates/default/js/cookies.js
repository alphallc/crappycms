function liveLoad(filename, filetype){
	var ft=filetype?filetype:filename.replace(/.+\./g,"");

	if (ft=="js") {
		var fileref=document.createElement('script');
		fileref.setAttribute("type","text/javascript");
		fileref.setAttribute("src", filename);
	} else if (ft=="css") {
		var fileref=document.createElement("link");
		fileref.setAttribute("rel", "stylesheet");
		fileref.setAttribute("type", "text/css");
		fileref.setAttribute("href", filename);
	}

	if (typeof fileref!="undefined") {
		document.getElementsByTagName("head")[0].appendChild(fileref);
	}
}

function liveRemove(filename, filetype){
	var ft=filetype?filetype:filename.replace(/.+\./g,"");
	var targetelement=(ft=="js")? "script" : (ft=="css")? "link" : "none";
	var targetattr=(ft=="js")? "src" : (ft=="css")? "href" : "none";
	var allsuspects=document.getElementsByTagName(targetelement);
	for (var i=allsuspects.length; i>=0; i--){
		if (allsuspects[i] && allsuspects[i].getAttribute(targetattr)!=null && allsuspects[i].getAttribute(targetattr).indexOf(filename)!=-1) {
			allsuspects[i].parentNode.removeChild(allsuspects[i]);
		}
	}
}

function setCookie (name, value, expires, path, domain, secure) {
	document.cookie = name + "=" + escape(value) +
		((expires) ? "; expires=" + expires : "") +
		((path) ? "; path=" + path : "") +
		((domain) ? "; domain=" + domain : "") +
		((secure) ? "; secure" : "");
}

function getCookie(name) {
	var cookie = " " + document.cookie;
	var search = " " + name + "=";
	var setStr = null;
	var offset = 0;
	var end = 0;
	if (cookie.length > 0) {
		offset = cookie.indexOf(search);
		if (offset != -1) {
			offset += search.length;
			end = cookie.indexOf(";", offset)
			if (end == -1) {
				end = cookie.length;
			}
			setStr = unescape(cookie.substring(offset, end));
		}
	}
	return(setStr);
}

function setTheme(name) {
	var old_theme = getCookie("theme");
	var new_theme = name;
	setCookie("theme",new_theme,null,"/");
	liveReloadTheme(old_theme,new_theme);
}

function liveReloadTheme(old_t,new_t) {
	if(!old_t) { old_t = "ClassicDark" }
	if(!new_t) { new_t = "ClassicDark" }
	liveRemove("/templates/default/css/themes/"+old_t+".css");
	liveLoad("/templates/default/css/themes/"+new_t+".css");
}
