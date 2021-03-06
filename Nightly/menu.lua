local sd2vita_callback = function ()
    sd2vita()
end

local installp_callback = function ()
    autoplugin()
end

local uinstallp_callback = function ()
    pluginsmanager()
end

local npdrm_callback = function ()
    npdrm_free()
end

local config_callback = function ()
    if back then back:blit(0,0) end
	files.copy("resources/pkgj/config.txt", "ux0:pkgi")
	message_wait(LANGUAGE["MENU_INSTALLED_CONFIG"])
	os.delay(2000)
end

local psp_ctrls_callback = function ()
    psp_ctrls()
end

local exit_callback = function ()
    if change then
		os.message(LANGUAGE["STRING_PSVITA_RESTART"])
		os.delay(250)
		buttons.homepopup(1)
		power.restart()
	end
	os.exit()
end

local menu = {
	{ text = LANGUAGE["MENU_INSTALL_SD2VITA"],			funct = sd2vita_callback },
	{ text = LANGUAGE["MENU_INSTALL_PLUGINS"],			funct = installp_callback },
	{ text = LANGUAGE["MENU_UNINSTALL_PLUGINS"],		funct = uinstallp_callback },
	{ text = LANGUAGE["MENU_INSTALL_CONFIG"],			funct = config_callback },
	{ text = LANGUAGE["MENU_INSTALL_NPDRMFREE"],		funct = npdrm_callback },
	{ text = LANGUAGE["MENU_INSTALL_REMASTERED_CTRLS"],	funct = psp_ctrls_callback },
	{ text = LANGUAGE["MENU_EXIT"],						funct = exit_callback }
}
local scrollm,sel = newScroll(menu,#menu),1

change = false
buttons.interval(10,10)
while true do
	if change then buttons.homepopup(0) else buttons.homepopup(1) end
	buttons.read()
	if back then back:blit(0,0) end

	screen.print(480,25,"Autoplugin",1.3,color.green, 0x0, __ACENTER)

	local y = 145
	for i=scrollm.ini, scrollm.lim do
		if i == scrollm.sel then draw.fillrect(0,y-7,960,29,color.green:a(90)) end
		screen.print(480,y,menu[i].text,1.2,color.white, 0x0, __ACENTER)
		y+=37
	end

	screen.flip()

	--Controls
	if buttons.up or buttons.analogly < -60 then scrollm:up() end
	if buttons.down or buttons.analogly > 60 then scrollm:down() end

	if buttons.cross then menu[scrollm.sel].funct()	end

end
