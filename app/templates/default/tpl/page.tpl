<!DOCTYPE html>
<!--[if IEMobile 7 ]>    <html class="no-js iem7"> <![endif]-->
<!--[if (gt IEMobile 7)|!(IEMobile)]><!--> <html class="no-js"> <!--<![endif]-->
<head>
	<meta charset="utf-8">
	<title>{*title*}</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<meta name="description" content="{*title*}"/>
	<meta name="MobileOptimized" content="176"/>
	<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1.0, maximum-scale=1.0, user-scalable=yes"/>
	<meta name="format-detection" content="telephone=no"/>
	<meta name="mobile-web-app-capable" content="yes"/>
	<meta name="apple-mobile-web-app-capable" content="yes"/>
	<link href="/favicon.png" rel="favicon" type="image/png">
	<link href="/favicon.png" rel="icon" type="image/png">
	<link href="/favicon.png" rel="shortcut icon" type="image/png">
	<link rel="shortcut icon" sizes="196x196" href="/favicon-196.png"/>
	<link rel="shortcut icon" sizes="128x128" href="/favicon-128.png"/>
	<link rel="apple-touch-icon" sizes="128x128" href="/favicon-128.png"/>
	<link rel="apple-touch-icon-precomposed" sizes="128x128" href="/favicon-128.png"/>
	<link rel="apple-touch-icon-precomposed" sizes="144x144" href="/favicon-144.png"/>
	<link rel="apple-touch-icon-precomposed" sizes="114x114" href="/favicon-114.png"/>
	<link rel="apple-touch-icon-precomposed" sizes="72x72" href="/favicon-72.png"/>
	<link rel="apple-touch-icon-precomposed" sizes="57x57" href="/favicon-57.png"/>
	<!-- Tile icon for Win8 (144x144 + tile color) -->
	<meta name="msapplication-TileImage" content="/favicon-144.png">
	<meta name="msapplication-TileColor" content="#222222">
{%
  local css = {"fonts","normalize"}
  local theme_name = cookie:get("theme");
  local theme = theme_name and theme_name:gsub("%.","%/") or "ClassicDark";
  table.insert(css, "themes/"..theme);
  for _,style in ipairs(context.css or {}) do
   table.insert(css, style)
  end
  for _,sheet in ipairs(css) do
%}
	<link href="/templates/default/css/{*sheet*}.css" rel="stylesheet" type="text/css">
{% end %}
	<script src="/templates/default/js/voting.js"></script>
	<script src="/templates/default/js/cookies.js"></script>
<!--[if lt IE 9]>
	<script src="/templates/default/js/ie/html5.js"></script>
	<script src="/templates/default/js/ie/css3_mq.js"></script>
<![endif]-->
	<script src="/templates/default/js/hooks.js"></script>
</head>
<body>
{(header.tpl)}
{(menu.tpl)}
<section id="base">
	<main id="content">
		{*body*}
	</main>
</section>
{%if q and q>20 then%}
{(menu.tpl)}
{%end%}
{(footer.tpl)}
</body>
</html>
