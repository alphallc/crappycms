local _T = {}

function _T.render_tpl(name,context)
    local context = context or {};
    error(name,":::",#context)
    return template.compile((name or "index")..".tpl",name)(context)
end

function _T.render_svg(name,size,context)
    local svg, size_h, size_w, vb;
    local context = context or {};
    local name = name or "misc/unknown";
    context.name = name;
    local ret = "";
--[[
    local sz = tonumber(size);
    if type(sz) == "number" then
        size_h = tostring(sz);
        size_w = tostring(sz);
    elseif type(size) == "table" then
        local h = tonumber(size[1]);
        local w = tonumber(size[2]);
        size_h = h and h or "16";
        size_w = w and w or "16";
    else
        size_h = "16";
        size_w = "16";
    end
]]

    if not svg_sprite_vb[name] then
        svg = template.compile("../img/"..name..".svg",name..".svg")(context);

        vb = svg:match([[viewBox=['"]([^'"]*)['"][ >].*]]) or "0 0 0 0";

        svg = svg:gsub([[viewBox=[^"' ]+]],"");
        svg = svg:gsub("width=[^ ]+","");
        svg = svg:gsub("height=[^ ]+","");
        svg = svg:gsub([[(<svg.*) (xmlns=)]],[[%1 viewBox="0 0 0 0" width=0 height=0 style="position:absolute;margin-left: -100%;" %2]]);

        svg_sprite_vb[name] = vb;
        ret = ret..svg;
    end

    ret = ret..[[<svg class="icon" viewBox="]]..svg_sprite_vb[name]..[[" width="100%" height="100%">
        <use xlink:href="#]]..name..[[">
    </svg>]]

    return ret
end

return _T;
