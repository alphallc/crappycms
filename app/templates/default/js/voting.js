window.onerror = function err() {return false;}
var req = new Array();
function vote(id,vote) {
	if (window.XMLHttpRequest) {
		req[id] = new XMLHttpRequest();
		req[id].onreadystatechange = (function() { processReqChange(id) });
		req[id].open("GET", "/vote?id=" + id + "&vote=" + vote, true);
		req[id].setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		req[id].send(null);
	} else if (window.ActiveXObject) {
		req[id] = new ActiveXObject("Microsoft.XMLHTTP");
		if (req[id]) {
			req[id].onreadystatechange = (function() { processReqChange(id) });
			req[id].open("GET", "/vote?id=" + id + "&vote=" + vote, true);
			req[id].setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			req[id].send();
		}
	} else return true;
	return false;
}

function processReqChange(id) {
	if (req[id].readyState == 4) {
		if (req[id].status == 200) {

			abc = req[id].responseText.split("=");
			document.getElementById(abc[0]).innerHTML = abc[1];
		}
	}
}


