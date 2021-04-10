local string = string;
string = require"core.string.utf8";
if app.utf8_string_patch then
  string.len = string.utf8_len;
  string.sub = string.utf8_sub;
  string.reverse = string.utf8_reverse;
  string.upper = string.utf8_upper;
  string.lower = string.utf8_lower;
end
string = require"core.string.extras";
return string;
