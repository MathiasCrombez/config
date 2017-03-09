-- Standard awesome library
local awful = require("awful")
local gears = require("gears")
local wall = require("gears.wallpaper")
local surface = require("gears.surface")
local wibox = require("wibox")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
-- Shifty script in shifty.lua
local shifty = require("shifty")
-- Vicious widget library
local vicious = require("vicious")
print("Entered rc.lua: " .. os.time())
require("calendar2")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- THEME
beautiful.init("/home/mathias/.config/awesome/themes/jack2/theme.lua")

wall.maximized("/home/mathias/.config/awesome/background/bg1.png", nil, true)


-- COLOURS
coldef = "</span>"
--colblk = "<span color='#1a1a1a'>"
colblk = "<span color='#000000'>"
colred = "<span color='#b23535'>"
colgre = "<span color='#60801f'>"
colyel = "<span color='#ffff33'>"
colora = "<span color='#be6e00'>"
colblu = "<span color='#1f6080'>"
colmag = "<span color='#8f46b2'>"
colcya = "<span color='#73afb4'>"
colwhi = "<span color='#b2b2b2'>"
colbblk = "<span color='#333333'>"
colbred = "<span color='#ff4b4b'>"
colbgre = "<span color='#9bcd32'>"
colbyel = "<span color='#cccc33'>"
colbora = "<span color='#d79b1e'>"
colbblu = "<span color='#329bcd'>"
colbmag = "<span color='#cd64ff'>"
colbcya = "<span color='#9bcdff'>"
colbwhi = "<span color='#ffffff'>"

-- DEFAULTS
terminal = "urxvt"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor
browser = "firefox"
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
}

-- shifty: predefined tags
shifty.config.tags = {
    ["1-term"]    = { init = true, position = 1, layout = awful.layout.suit.max		    },
    ["2-web"]     = { position = 2, layout = awful.layout.suit.floating                     },
    ["3-work"]   = { position = 3, layout = awful.layout.suit.max                          },
}

-- shifty: tags matching and client rules
shifty.config.apps = {
    { match = { "Firefox", "Iceweasel" }, tag = "2-web", },
    { match = { "Comix", "feh", "MComix", "gvbam" }, tag = "3-manga", },
    { match = { "gitg" }, tag = "3-work", },
    { match = { "MPlayer", "Vlc", "mplayer" }, tag = "4-video", },
    { match = { "MPlayer", "mplayer" }, geometry = {0,15,nil,nil}, float = true },
    { match = { "ncmpc++" ,"ncmpcpp"}, tag = "5-music", },
    { match = { "irssi", "Skype", "mutt", "newsbeuter" }, tag = "6-irc", },
    { match = { "LibreOffice.org 3.5" }, tag = "7-office", },
    { match = { "Xpdf" }, tag = "8-pdf", },
    -- client manipulation
    { match = { "" },
    honorsizehints = false,
    buttons = 
    awful.util.table.join (
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))
},
}

-- shifty: defaults
shifty.config.defaults = {
    layout = awful.layout.suit.max,
    ncol = 1,
    mwfact = 0.5,
    guess_name = true,
    guess_position = true,
}
shifty.config.layouts = layouts

-- MENU

-- WIDGETS TOP

-- Spacer widget
spacerwidget = wibox.widget.imagebox()
spacerwidget:set_image("/home/mathias/.config/awesome/themes/jack2/spacer.png")


-- Calendar widget
calwidget = wibox.widget.textbox()
function dayth()
    local osd = os.date("%d")
    if osd == "01" or osd == "21" or osd == "31" then
	return "<span font='proggytiny 7'><sup>st</sup></span>"
    elseif osd == "02" or osd == "22" then
	return "<span font='proggytiny 7'><sup>nd</sup></span>"
    elseif osd == "03" or osd == "23" then
	return "<span font='proggytiny 7'><sup>rd</sup></span>"
    else
	return "<span font='proggytiny 7'><sup>th</sup></span>"
    end
end
vicious.register(calwidget, vicious.widgets.date, "" .. colwhi .. "%F" .. coldef .. " - ")
calendar2.addCalendarToWidget(calwidget, "" .. colora .. "%s" .. coldef .. "")

-- Clock widget
clockwidget = wibox.widget.textbox()
vicious.register(clockwidget, vicious.widgets.date, "" .. colbblu .. "%H:%M" .. coldef .. "")

local function time_cet()
    local time = os.time()
    time2 = time - (8*3600)
    local new_time = os.date("%a, %I:%M%P", time2)
    return new_time
end
local function time_utc()
    local time = os.time()
    time2 = time - (9*3600)
    local new_time = os.date("%a, %I:%M%P", time2)
    return new_time
end
local function time_nzst()
    local time = os.time()
    time2 = time + (2*3600)
    local new_time = os.date("%a, %I:%M%P", time2)
    return new_time
end
local function time_ckt()
    local time = os.time()
    time2 = time - (20*3600)
    local new_time = os.date("%a, %I:%M%P", time2)
    return new_time
end
local function time_pst()
    local time = os.time()
    time2 = time - (17*3600)
    local new_time = os.date("%a, %I:%M%P", time2)
    return new_time
end
local function time_est()
    local time = os.time()
    time2 = time - (14*3600)
    local new_time = os.date("%a, %I:%M%P", time2)
    return new_time
end


-- CPU widget
cputwidget = wibox.widget.textbox()
vicious.register(cputwidget, vicious.widgets.cpu,
function (widget, args)
	return "" .. colwhi .. "cpu " .. coldef .. colbblu .. args[1] .. "% | " .. coldef .. ""
end )
cputwidget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn ( terminal .. " -e htop --sort-key PERCENT_CPU") end ) ) )

-- Ram widget
memwidget = wibox.widget.textbox()
vicious.cache(vicious.widgets.mem)
vicious.register(memwidget, vicious.widgets.mem, "" .. colwhi .. "mem " .. coldef .. colbblu .. "$1% | " .. coldef .. "", 13)

-- Volume widget
volwidget = wibox.widget.textbox()
vicious.register(volwidget, vicious.widgets.volume,
function (widget, args)
    if args[1] == 0 or args[2] == "♩" then
	return "" .. colwhi .. "vol " .. coldef .. colbblu .. "0% | " .. coldef .. ""
    else
	return "" .. colwhi .. "vol " .. coldef .. colbblu .. args[1] .. "% | " .. coldef .. ""
    end
end, 2, "Master" )
volwidget:buttons(
    awful.util.table.join(
	awful.button({ }, 1, function () awful.util.spawn("amixer -q sset Master toggle") end),
	awful.button({ }, 3, function () awful.util.spawn( terminal .. " -e alsamixer") end),
	awful.button({ }, 4, function () awful.util.spawn("amixer -q sset Master 2dB+") end),
	awful.button({ }, 5, function () awful.util.spawn("amixer -q sset Master 2dB-") end)
		     )
		 )

-- WIBOXES
mywibox = {}
infobox = {}
mypromptbox = {}
-- taglist
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
awful.button({ }, 1, awful.tag.viewonly),
awful.button({ modkey }, 1, awful.client.movetotag),
awful.button({ }, 3, awful.tag.viewtoggle),
awful.button({ modkey }, 3, awful.client.toggletag),
awful.button({ }, 4, awful.tag.viewnext),
awful.button({ }, 5, awful.tag.viewprev)
)

-- tasklist
mytasklist = {}
mytasklist.buttons = 
awful.util.table.join(
awful.button({ }, 1, function (c)
    if not c:isvisible() then
	awful.tag.viewonly(c:tags()[1])
    end
    client.focus = c
    c:raise()
end),
awful.button({ }, 3, function ()
    if instance then
	instance:hide()
	instance = nil
    else
	instance = awful.menu.clients({ width=250 })
    end
end),
awful.button({ }, 4, function ()
    awful.client.focus.byidx(1)
    if client.focus then
	client.focus:raise()
    end
end),
awful.button({ }, 5, function ()
    awful.client.focus.byidx(-1)
    if client.focus then
	client.focus:raise()
    end
end)		      
)


for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)
    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", height = "14", screen = s })
    -- Add widgets to the wibox - order matters
    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mytaglist[s])
    left_layout:add(spacerwidget)
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
	--       mpdwidget,
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(cputwidget)
    right_layout:add(memwidget)
    right_layout:add(volwidget)
    right_layout:add(calwidget)    
    right_layout:add(clockwidget)

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end

-- SHIFTY: initialize shifty
-- the assignment of shifty.taglist must always be after its actually
-- initialized with awful.widget.taglist.new()
shifty.taglist = mytaglist
shifty.init()


-- Mouse bindings
root.buttons(awful.util.table.join(
		 awful.button({ }, 3, function () mymainmenu:toggle() end),
		 awful.button({ }, 4, awful.tag.viewnext),
		 awful.button({ }, 5, awful.tag.viewprev)
				  ))
    -- 

    -- Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey, "Shift"   }, "Left",   shifty.shift_prev        ),
    awful.key({ modkey, "Shift"   }, "Right",  shifty.shift_next        ),
    awful.key({ modkey            }, "a",      function() shifty.add({ rel_index = 1 }) end ),
    awful.key({ modkey, "Shift"   }, "a",      function() shifty.add({ rel_index = 1, nopopup = true }) end ),
    awful.key({ modkey            }, "z",      shifty.del ),

    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
    function ()
	awful.client.focus.byidx( 1)
	if client.focus then client.focus:raise() end
    end),
    awful.key({ modkey,           }, "k",
    function ()
	awful.client.focus.byidx(-1)
	if client.focus then client.focus:raise() end
    end),
    --    awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
    function ()
	awful.client.focus.history.previous()
	if client.focus then
	    client.focus:raise()
	end
    end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    -- general programs
    awful.key({ modkey,           }, "F1",    function () awful.util.spawn("firefox") end),
    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
	      function ()
		  awful.prompt.run({ prompt = "Run Lua code: " },
				   mypromptbox[mouse.screen].widget,
				   awful.util.eval, nil,
				   awful.util.getdir("cache") .. "/history_eval")
	      end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),
    awful.key({ modkey,           }, "m",
	      function (c)
		  c.maximized_horizontal = not c.maximized_horizontal
		  c.maximized_vertical   = not c.maximized_vertical
	      end)			      
)


-- WORKSPACES
-- shifty:
for i=1,9 do
    globalkeys = awful.util.table.join(
	globalkeys, 
	awful.key({ modkey }, "#" .. i + 9, 
		  function ()
		      local t = awful.tag.viewonly(shifty.getpos(i))
		  end))
    globalkeys = awful.util.table.join(
	globalkeys, 
	awful.key({ modkey, "Control" }, "#" .. i + 9, 
		  function ()
		      local t = shifty.getpos(i)
		      t.selected = not t.selected
		  end))
    globalkeys = awful.util.table.join(
	globalkeys, 
	awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, 
		  function ()
		      if client.focus then
			  awful.client.toggletag(shifty.getpos(i))
		      end
		  end))
    globalkeys = awful.util.table.join(
	globalkeys, 
	awful.key({ modkey, "Shift" }, "#" .. i + 9, 
		  function ()
		      if client.focus then
			  local t = shifty.getpos(i)
			  awful.client.movetotag(t)
			  awful.tag.viewonly(t)
		      end
		  end))
end

-- Set keys
root.keys(globalkeys)
shifty.config.globalkeys = globalkeys
shifty.config.clientkeys = clientkeys
shifty.config.modkey = modkey

-- Signals
-- Signal function to execute when a new client appears.
client.connect_signal(
    "manage", 
    function (c, startup)
        if not startup then
            if not c.size_hints.user_position and not c.size_hints.program_position then
                awful.placement.no_overlap(c)
                awful.placement.no_offscreen(c)
            end
        end
    end
)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- 
