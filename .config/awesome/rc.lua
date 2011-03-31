-- Standard awesome library
require("awful")
require("awful.autofocus")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- Shifty script in shifty.lua
require("shifty")
-- Vicious widget library
require("vicious")

require("calendar2")

-- THEME
beautiful.init("/home/mathias/.config/awesome/themes/jack2/theme.lua")

-- COLOURS
coldef = "</span>"
--colblk = "<span color='#1a1a1a'>"
colblk = "<span color='#000000'>"
colred = "<span color='#b23535'>"
colgre = "<span color='#60801f'>"
colyel = "<span color='#be6e00'>"
colblu = "<span color='#1f6080'>"
colmag = "<span color='#8f46b2'>"
colcya = "<span color='#73afb4'>"
colwhi = "<span color='#b2b2b2'>"
colbblk = "<span color='#333333'>"
colbred = "<span color='#ff4b4b'>"
colbgre = "<span color='#9bcd32'>"
colbyel = "<span color='#d79b1e'>"
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
   ["1-term"]    = { init = true, position = 1, layout = awful.layout.suit.fair.horizontal },
   ["2-web"]     = { position = 2, layout = awful.layout.suit.max                          },
   ["3-manga"]   = { position = 3, layout = awful.layout.suit.max                          },
   ["4-video"]   = { position = 4, layout = awful.layout.suit.floating                     },
   ["5-music"]   = { position = 5, layout = awful.layout.suit.tile.bottom                  },
   ["6-office"]  = { position = 6, layout = awful.layout.suit.tile.bottom                  },
   ["7-pdf"]     = { position = 7, layout = awful.layout.suit.tile.bottom                  },
   ["torrent"]   = { layout = awful.layout.suit.max                                        },
}

-- shifty: tags matching and client rules
shifty.config.apps = {
   { match = { "Firefox" }, tag = "2-web", },
   { match = { "Comix" }, tag = "3-manga", },   
   { match = { "MPlayer", "Vlc" }, tag = "4-video", },
   { match = { "MPlayer" }, geometry = {0,15,nil,nil}, float = true },
   { match = { "ncmpcpp" }, tag = "5-music", },
   { match = { "LibreOffice.org 3.3" }, tag = "6-office", },
--   { match = {  }, tag = "7-pdf", },
   { match = { "rtorrent" }, tag = "torrent", },
--   { match = { "Mirage", "Geeqie" }, tag = "picture", },
--   { match = { "wicd%-curses", "wvdial" }, tag = "dial", },
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
}
shifty.config.layouts = layouts
shifty.init()

-- MENU

-- WIDGETS TOP

-- Spacer widget
spacerwidget = widget({ type = "imagebox" })
spacerwidget.image = image("/home/mathias/.config/awesome/themes/jack2/spacer.png")


-- Calendar widget
calwidget = widget({ type = "textbox" })
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
vicious.register(calwidget, vicious.widgets.date, "" .. colyel .. " %a, %e" .. dayth() .. " %B" .. coldef .. " ")
calendar2.addCalendarToWidget(calwidget, "" .. colyel .. "%s" .. coldef .. "")

-- Clock widget
clockwidget = widget({ type = "textbox" })
vicious.register(clockwidget, vicious.widgets.date, "" .. colbyel .. "%l:%M%P" .. coldef .. "")
function cal_gett()
   local fp = io.popen("remind /home/mathias/.reminders")
   local rem = fp:read("*a")
   fp:close()
   rem = string.gsub(rem, "\027%[0m", "</span>")
   rem = string.gsub(rem, "\027%[0;30m", "<span color='#1a1a1a'>") --black
   rem = string.gsub(rem, "\027%[0;31m", "<span color='#b23535'>") --red
   rem = string.gsub(rem, "\027%[0;32m", "<span color='#60801f'>") --green
   rem = string.gsub(rem, "\027%[0;33m", "<span color='#be6e00'>") --yellow
   rem = string.gsub(rem, "\027%[0;34m", "<span color='#1f6080'>") --blue
   rem = string.gsub(rem, "\027%[0;35m", "<span color='#8f46b2'>") --magenta
   rem = string.gsub(rem, "\027%[0;36m", "<span color='#73afb4'>") --cyan
   rem = string.gsub(rem, "\027%[0;37m", "<span color='#b2b2b2'>") --white
   rem = string.gsub(rem, "\027%[1;30m", "<span color='#4c4c4c'>") --br-black
   rem = string.gsub(rem, "\027%[1;31m", "<span color='#ff4b4b'>") --br-red
   rem = string.gsub(rem, "\027%[1;32m", "<span color='#9bcd32'>") --br-green
   rem = string.gsub(rem, "\027%[1;33m", "<span color='#d79b1e'>") --br-yellow
   rem = string.gsub(rem, "\027%[1;34m", "<span color='#329bcd'>") --br-blue
   rem = string.gsub(rem, "\027%[1;35m", "<span color='#cd64ff'>") --br-magenta
   rem = string.gsub(rem, "\027%[1;36m", "<span color='#9bcdff'>") --br-cyan
   rem = string.gsub(rem, "\027%[1;37m", "<span color='#ffffff'>") --br-white
   return rem
end
clockwidget:add_signal('mouse::enter', function () cal_remt = { naughty.notify({ text = cal_gett(), border_color = "#1a1a1a", timeout = 0, hover_timeout = 0.5 }) } end)
clockwidget:add_signal('mouse::leave', function () naughty.destroy(cal_remt[1]) end)

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

-- Weather widget
weatherwidget = widget({ type = "textbox" })
	vicious.register(weatherwidget, vicious.widgets.weather,
			 function (widget, args)
			    if args["{tempc}"] == "N/A" then
			       return ""
			    else
			       weatherwidget:add_signal('mouse::enter', function () weather_n = { naughty.notify({ title = "" .. colblu .. "───────────── Weather ─────────────" .. coldef .. "", text = "" .. colbblu .. "Wind    : " .. args["{windkmh}"] .. " km/h " .. args["{wind}"] .. "\nHumidity: " .. args["{humid}"] .. " %\nPressure: " .. args["{press}"] .. " hPa" .. coldef .. "", border_color = "#1a1a1a", timeout = 0, hover_timeout = 0.5 }) } end) 
			       weatherwidget:add_signal('mouse::leave', function () naughty.destroy(weather_n[1]) end)
			       return "" .. colblu .. " weather " .. coldef .. colbblu .. string.lower(args["{sky}"]) .. ", " .. args["{tempc}"] .. "°C" .. coldef .. ""
			    end
			 end, 1200, "LFPO" )
	weatherwidget:buttons(awful.util.table.join(awful.button({}, 3, function () awful.util.spawn ( browser .. " http://france.meteofrance.com/france/meteo?PREVISIONS_PORTLET.path=previsionsville/750560/") end)))



-- CPU widget
cputwidget = widget({ type = "textbox" })
vicious.register(cputwidget, vicious.widgets.cpu,
		 function (widget, args)
		    if args[1] == 50 then
		       return "" .. colyel .. "cpu " .. coldef .. colbyel .. args[1] .. "% " .. coldef .. ""
		    elseif args[1] >= 50 then
		       return "" .. colred .. "cpu " .. coldef .. colbred .. args[1] .. "% " .. coldef .. ""
		    else
		       return "" .. colblk .. "cpu " .. coldef .. colbblk .. args[1] .. "% " .. coldef .. ""
		    end
		 end )
cputwidget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn ( terminal .. " -e htop --sort-key PERCENT_CPU") end ) ) )

-- CPU temp widget
tempwidget = widget({ type = "textbox" })
vicious.register(tempwidget, vicious.widgets.thermal,
		 function (widget, args)
		    if args[1] >= 50 and args[1] < 60 then
		       return "" .. colgre .. "temp " .. coldef .. colbgre .. args[1] .. "°C " .. coldef .. ""
		    elseif args[1] >= 60 and args[1] < 70 then
		       return "" .. colyel .. "temp " .. coldef .. colbyel .. args[1] .. "°C " .. coldef .. ""
		    elseif args[1] >= 70 and args[1] < 80 then
		       return "" .. colred .. "temp " .. coldef .. colbred .. args[1] .. "°C " .. coldef .. ""
		    elseif args[1] > 80 then
		       naughty.notify({ title = "Temperature Warning", text = "Running hot! " .. args[1] .. "°C!\nTake it easy.", timeout = 10, position = "top_right", fg = beautiful.fg_urgent, bg = beautiful.bg_urgent })
		       return "" .. colred .. "temp " .. coldef .. colbred .. args[1] .. "°C " .. coldef .. ""
		    else
		       return "" .. colblk .. "temp " .. coldef .. colbblk .. args[1] .. "°C " .. coldef .. ""
		    end
		 end, 19, "thermal_zone0" )

-- Ram widget
memwidget = widget({ type = "textbox" })
vicious.cache(vicious.widgets.mem)
vicious.register(memwidget, vicious.widgets.mem, "" .. colblk .. "ram " .. coldef .. colbblk .. "$1% ($2 MiB) " .. coldef .. "", 13)

-- Filesystem widgets
-- root
fsrwidget = widget({ type = "textbox" })
vicious.register(fsrwidget, vicious.widgets.fs,
		 function (widget, args)
		    if args["{/ used_p}"] >= 93 and args["{/ used_p}"] < 97 then
		       return "" .. colyel .. "/ " .. coldef .. colbyel .. args["{/ used_p}"] .. "% (" .. args["{/ avail_gb}"] .. " GiB free) " .. coldef .. ""
		    elseif args["{/ used_p}"] >= 97 and args["{/ used_p}"] < 99 then
		       return "" .. colred .. "/ " .. coldef .. colbred .. args["{/ used_p}"] .. "% (" .. args["{/ avail_gb}"] .. " GiB free) " .. coldef .. ""
		    elseif args["{/ used_p}"] >= 99 and args["{/ used_p}"] <= 100 then
		       naughty.notify({ title = "Hard drive Warning", text = "No space left on root!\nMake some room.", timeout = 10, position = "top_right", fg = beautiful.fg_urgent, bg = beautiful.bg_urgent })
		       return "" .. colred .. "/ " .. coldef .. colbred .. args["{/ used_p}"] .. "% (" .. args["{/ avail_gb}"] .. " GiB free) " .. coldef .. ""
		    else
		       return "" .. colblk .. "/ " .. coldef .. colbblk .. args["{/ used_p}"] .. "% (" .. args["{/ avail_gb}"] .. " GiB free) " .. coldef .. ""
		    end
		 end, 620)
-- /home
fshwidget = widget({ type = "textbox" })
vicious.register(fshwidget, vicious.widgets.fs,
		 function (widget, args)
		    if args["{/home used_p}"] >= 97 and args["{/home used_p}"] < 98 then
		       return "" .. colyel .. "/home " .. coldef .. colbyel .. args["{/home used_p}"] .. "% (" .. args["{/home avail_gb}"] .. " GiB free) " .. coldef .. ""
		    elseif args["{/home used_p}"] >= 98 and args["{/home used_p}"] < 99 then
		       return "" .. colred .. "/home " .. coldef .. colbred .. args["{/home used_p}"] .. "% (" .. args["{/home avail_gb}"] .. " GiB free) " .. coldef .. ""
		    elseif args["{/home used_p}"] >= 99 and args["{/home used_p}"] <= 100 then
		       naughty.notify({ title = "Hard drive Warning", text = "No space left on /home!\nMake some room.", timeout = 10, position = "top_right", fg = beautiful.fg_urgent, bg = beautiful.bg_urgent })
		       return "" .. colred .. "/home " .. coldef .. colbred .. args["{/home used_p}"] .. "% (" .. args["{/home avail_gb}"] .. " GiB free) " .. coldef .. ""
		    else
		       return "" .. colblk .. "/home " .. coldef .. colbblk .. args["{/home used_p}"] .. "% (" .. args["{/home avail_gb}"] .. " GiB free) " .. coldef .. ""
		    end
		 end, 620)

-- Net widgets
-- eth
neteupwidget = widget({ type = "textbox" })
vicious.cache(vicious.widgets.net)
vicious.register(neteupwidget, vicious.widgets.net, "" .. colblk .. "up " .. coldef .. colbblk .. "${eth0 up_kb} " .. coldef .. "")

netedownwidget = widget({ type = "textbox" })
vicious.register(netedownwidget, vicious.widgets.net, "" .. colblk .. "down " ..coldef .. colbblk .. "${eth0 down_kb} " .. coldef .. "")

netwidget = widget({ type = "textbox" })
vicious.register(netwidget, vicious.widgets.netinfo,
		 function (widget, args)
		    if args["{ip}"] == nil then
		       netedownwidget.visible = false
		       neteupwidget.visible = false
		       return ""
		    else
		       netedownwidget.visible = true
		       neteupwidget.visible = true
		       return "" .. colblk .. "eth0 " .. coldef .. colbblk .. args["{ip}"] .. coldef .. " "
		    end
		 end, refresh_delay, "eth0")

-- wlan
netwupwidget = widget({ type = "textbox" })
vicious.register(netwupwidget, vicious.widgets.net, "" .. colblk .. "up " .. coldef .. colbblk .. "${wlan0 up_kb} " .. coldef .. "")

netwdownwidget = widget({ type = "textbox" })
vicious.register(netwdownwidget, vicious.widgets.net, "" .. colblk .. "down " .. coldef .. colbblk .. "${wlan0 down_kb} " .. coldef .. "")

wifiwidget = widget({ type = "textbox" })
vicious.register(wifiwidget, vicious.widgets.wifi,
		 function (widget, args)
		    if args["{link}"] == 0 then
		       netwdownwidget.visible = false
		       netwupwidget.visible = false
		       return ""
		    else
		       netwdownwidget.visible = true
		       netwupwidget.visible = true
		       return "" .. colblk .. "wlan " .. coldef .. colbblk .. string.format("%s [%i%%]", args["{ssid}"], args["{link}"]/70*100) .. coldef .. " "
		    end
		 end, refresh_delay, "wlan0" )

-- Battery widget
batwidget = widget({ type = "textbox" })
vicious.register(batwidget, vicious.widgets.bat,
		 function (widget, args)
		    if args[2] >= 50 and args[2] < 75 then
		       return "" .. colyel .. "bat " .. coldef .. colbyel .. args[2] .. "% " .. coldef .. ""
		    elseif args[2] >= 20 and args[2] < 50 then
		       return "" .. colred .. "bat " .. coldef .. colbred .. args[2] .. "% " .. coldef .. ""
		    elseif args[2] < 20 and args[1] == "-" then
		       naughty.notify({ title = "Battery Warning", text = "Battery low! "..args[2].."% left!\nBetter get some power.", timeout = 10, position = "top_right", fg = beautiful.fg_urgent, bg = beautiful.bg_urgent })
		       return "" .. colred .. "bat " .. coldef .. colbred .. args[2] .. "% " .. coldef .. ""
		    elseif args[2] < 20 then
		       return "" .. colred .. "bat " .. coldef .. colbred .. args[2] .. "% " .. coldef .. ""
		    else
		       return "" .. colblk .. "bat " .. coldef .. colbblk .. args[2] .. "% " .. coldef .. ""
		    end
		 end, 23, "BAT0" )

-- Volume widget
-- volwidget = widget({ type = "textbox" })
-- vicious.register(volwidget, vicious.widgets.volume,
-- 		 function (widget, args)
-- 		    if args[1] == 0 or args[2] == "♩" then
-- return "" .. colblk .. "vol " .. coldef .. colbred .. "mute" .. coldef .. ""
-- 		    else
-- 		       return "" .. colblk .. "vol " .. coldef .. colbblk .. args[1] .. "% " .. coldef .. ""
-- 		    end
-- 		 end, 2, "Master" )
-- volwidget:buttons(
-- awful.util.table.join(
-- 		      awful.button({ }, 1, function () awful.util.spawn("amixer -q sset Master toggle") end),
-- 		      awful.button({ }, 3, function () awful.util.spawn( terminal .. " -e alsamixer") end),
-- 		      awful.button({ }, 4, function () awful.util.spawn("amixer -q sset Master 2dB+") end),
-- 		      awful.button({ }, 5, function () awful.util.spawn("amixer -q sset Master 2dB-") end)
-- 		   )
-- )

soundIndex = 2
-- Volume widget for Pulseaudio
volwidget = widget({ type = "textbox" })
vicious.register(volwidget, vicious.contrib.pulse,
		 function (widget, args)
		    if args[1] == 0 or args[2] == "off" then
		       return "" .. colblk .. "vol " .. coldef .. colbred .. "mute" .. coldef .. ""
		    else
		       return "" .. colblk .. "vol " .. coldef .. colbblk .. string.format("%.0f", args[1]) .. "% " .. coldef .. ""
		    end
 		 end, 0.5, soundIndex )
-- 		 end, 10, "alsa_output.usb-Logitech_Logitech_USB_Headset-00-Headset.analog-stereo" )
volwidget:buttons(awful.util.table.join( 
    awful.button({ }, 1, function () vicious.contrib.pulse.toggle(soundIndex) end),
    awful.button({ }, 3, function ()
    			    if soundIndex == 2 then 
    			       vicious.contrib.pulse.toggle(2)
    			       soundIndex = 1
    			       vicious.contrib.pulse.toggle(1)
    			    else
    			       vicious.contrib.pulse.toggle(1)
    			       soundIndex = 2			 
    			       vicious.contrib.pulse.toggle(2)
			    end
    			 end),
    awful.button({ }, 4, function () vicious.contrib.pulse.add(5,soundIndex) end),
    awful.button({ }, 5, function () vicious.contrib.pulse.add(-5,soundIndex) end)
))


-- MPD widget
mpdwidget = widget({ type = 'textbox' })
	vicious.register(mpdwidget, vicious.widgets.mpd,
		function (widget, args)
			if args["{state}"] == "Stop" then
				return ""
			elseif args["{state}"] == "Play" then
				return "" .. colblk .. "mpd " .. coldef .. colbblk .. args["{Artist}"] .. " - " .. args["{Album}"] .. " - " .. args["{Title}"] .. coldef .. ""
			elseif args["{state}"] == "Pause" then
				return "" .. colblk .. "mpd " .. coldef .. colbyel .. "paused" .. coldef .. ""
			end
		end)
	mpdwidget:buttons(
		awful.util.table.join(
			awful.button({}, 1, function () awful.util.spawn("mpc toggle", false) end),
			awful.button({}, 2, function () awful.util.spawn( terminal .. " -e ncmpcpp")   end),
			awful.button({}, 4, function () awful.util.spawn("mpc prev", false) end),
			awful.button({}, 5, function () awful.util.spawn("mpc next", false) end)
		)
	)


-- SYSTRAY
mysystray = widget({ type = "systray" })

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
shifty.taglist = mytaglist


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
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)
    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", height = "14", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = { {
	  mytaglist[s], spacerwidget,
	  mypromptbox[s], layout = awful.widget.layout.horizontal.leftright },
       clockwidget,
       calwidget,
       weatherwidget,
       spacerwidget,
    --    layout = awful.widget.layout.horizontal.rightleft }

    -- -- bottom box
    -- infobox[s] = awful.wibox({ position = "bottom", height = "14", screen = s })
    -- infobox[s].widgets = { {
    -- 	  mpdwidget, layout = awful.widget.layout.horizontal.leftright },
       volwidget,
       batwidget,
       neteupwidget, netedownwidget, netwidget,
       netwupwidget, netwdownwidget, wifiwidget,
       fshwidget, fsrwidget,
       memwidget,
       tempwidget,
       cputwidget,
       mpdwidget,
       s == 1 and mysystray or nil,
       mytasklist[s],
       layout = awful.widget.layout.horizontal.rightleft }
end

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
   globalkeys = awful.util.table.join(globalkeys, 
         awful.key({ modkey }, "#" .. i + 9, function ()
				     local t = awful.tag.viewonly(shifty.getpos(i))
				  end))
   globalkeys = awful.util.table.join(globalkeys, 
         awful.key({ modkey, "Control" }, "#" .. i + 9, function ()
						local t = shifty.getpos(i)
						t.selected = not t.selected
					     end))
   globalkeys = awful.util.table.join(globalkeys, 
	 awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function ()
							 if client.focus then
							    awful.client.toggletag(shifty.getpos(i))
							 end
										   end))
   globalkeys = awful.util.table.join(globalkeys, 
	 awful.key({ modkey, "Shift" }, "#" .. i + 9, function ()
					      if client.focus then
						 local t = shifty.getpos(i)
						 awful.client.movetotag(t)
						 awful.tag.viewonly(t)
					      end
					   end))
end


-- clientbuttons = awful.util.table.join(
--     awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
--     awful.button({ modkey }, 1, awful.mouse.client.move),
--     awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
shifty.config.globalkeys = globalkeys
shifty.config.clientkeys = clientkeys


-- Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    if not startup then
       if not c.size_hints.user_position and not c.size_hints.program_position then
	  awful.placement.no_overlap(c)
	  awful.placement.no_offscreen(c)
       end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- 
