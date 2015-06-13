require "util"
require "defines"
require "config"

game.oninit(function()
  glob.tickCounter = 0
  glob.amount = 0
end)

game.onevent(defines.events.ontick, function(event)
	glob.tickCounter = glob.tickCounter + 1
	if glob.tickCounter / (ticksPerSecondCFG * game.speed) > timeDifferenceCFG then	-- this counter is necessary as the lua in Factorio doesn't have access to any libraries, so I can't keep track of time in any other way
		glob.tickCounter = 0
		glob.amount = glob.amount + 1

		if centerOnPlayerCFG and centerOnPositionCFG then
  			game.player.print("ERROR!")
  			game.player.print("centerOnPlayer and centerOnPositon are enabled at the same time. Please check your config.lua file")
  			game.player.print("Please change your config.lua file and RESTART Factorio. This message will only be shown ONCE")
			game.onevent(defines.events.ontick, nil) -- this is done so Factorio unsubscribes from the ontick event as it isn't needed if the screenshot ability doesn't work and therefore improves performance
  			return
  		end

  		if not centerOnPlayerCFG and not centerOnPositionCFG then
  			game.player.print("ERROR!")
  			game.player.print("centerOnPlayer and centerOnPositon are disabled at the same time. Please check your config.lua file")
  			game.player.print("Please change your config.lua file and RESTART Factorio. This message will only be shown ONCE")
			game.onevent(defines.events.ontick, nil) -- this is done so Factorio unsubscribes from the ontick event as it isn't needed if the screenshot ability doesn't work and therefore improves performance
  			return
  		end

  		if centerOnPlayerCFG then
  			local pathName = genPathName(pathCFG, screenshotnameCFG, glob.amount)
  			game.takescreenshot{resolution = resolutionCFG, zoom = zoomCFG, path = pathName, showguiCFG, showentityinfoCFG}
  			game.player.print("screenshot taken on player!")
  		elseif centerOnPositionCFG then
  			local pathName = genPathName(pathCFG, screenshotnameCFG, glob.amount)
  			game.takescreenshot{position = positionCFG, resolution = resolutionCFG, zoom = zoomCFG, path = pathName, showguiCFG, showentityinfoCFG}
  			game.player.print("screenshot taken on positon!")
  		else
  			game.player.print("ERROR!")
  			game.player.print("Something really unexpected/terrible happened. This should never happen!")
  			game.onevent(defines.events.ontick, nil) -- this is done so Factorio unsubscribes from the ontick event as it isn't needed if something goes wrong majorly and therefore improves performance
  			return
  		end

	end
end)

function genPathName(pathCFG, screenshotnameCFG, amount)
	return pathCFG .. "/" .. screenshotnameCFG .. amount .. ".png"
end
