<?xml version="1.0" encoding="utf-8"?>
<rss version="2.0">
	<channel>
		<title>iBash.IM</title>
		<link>http://ibash.im/</link>
		<description>Новый цитатник Рунета</description>
		<language>ru</language>
{%
for _,quote in ipairs(quotes) do
local pub_t={};
pub_t.year,pub_t.month,pub_t.day,pub_t.hour,pub_t.min,pub_t.sec = (quote.date_approved):match("(%d%d%d%d)-(%d%d)-(%d%d) (%d%d):(%d%d):(%d%d)");
local pub = os.date('%a, %d %b %Y %T UTC',os.time(pub_t));
%}
		<item>
			<guid>http://ibash.im/quote?id={{quote.id}}</guid>
			<link>http://ibash.im/quote?id={{quote.id}}</link>
			<title>Цитата #{{quote.id}}</title>
			<pubDate>{{pub}}</pubDate>
			<description><![CDATA[{*quote.body*}]]></description>
		</item>
{%end%}
	</channel>
</rss>

