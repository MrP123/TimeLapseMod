require "util"
require "defines"
require "config"

game.oninit(function()
  glob.tickCounter = 0
  glob.amount = 0
  glob.time = -1
  glob.shouldUpdate = false

  remote.addinterface("TLM_commands", {
    -- "console command" to set the screenshot position to the current player position
    setPositionPlayer = function()
      positionCFG = game.player.position
    end,

    -- "console command" to set the screenshot position to the specified x and y value
    setPositionXY = function(x, y)
      positionCFG.x = x
      positionCFG.y = y
    end
  })

end)

game.onevent(defines.events.ontick, function(event)
  if glob.shouldUpdate then
    restoreTime()
    glob.time = -1
    glob.shouldUpdate = false
  end

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
      makeNoon()

      local pathName = genPathName(pathCFG, screenshotnameCFG, glob.amount)
      game.takescreenshot{resolution = resolutionCFG, zoom = zoomCFG, path = pathName, showguiCFG, showentityinfoCFG}
      printMessage()
    elseif centerOnPositionCFG then
      makeNoon()

      local pathName = genPathName(pathCFG, screenshotnameCFG, glob.amount)
      game.takescreenshot{position = positionCFG, resolution = resolutionCFG, zoom = zoomCFG, path = pathName, showguiCFG, showentityinfoCFG}
      printMessage()
    else
      game.player.print("ERROR!")
      game.player.print("Something really unexpected/terrible happened. This should never happen!")
  	  game.onevent(defines.events.ontick, nil) -- this is done so Factorio unsubscribes from the ontick event as it isn't needed if something goes wrong majorly and therefore improves performance
      return
    end
  end
end)

function genPathName(pathCFG, screenshotnameCFG, amount)
  return pathCFG .. "/" .. screenshotnameCFG .. string.format(numberFormatCFG, amount) .. ".png"
end

function makeNoon()
  if onlyDayScreenshotsCFG then
    glob.time = game.daytime
    game.daytime = 0
    glob.shouldUpdate = true
  else
    glob.time = -1
  end
end

function restoreTime()
  if glob.time ~= -1 then
    game.daytime = glob.time
  end
end

function printMessage()
  if printMessageCFG and centerOnPlayerCFG then
    game.player.print("screenshot taken on player!")
  elseif printMessageCFG and centerOnPositionCFG then
    game.player.print("screenshot taken on positon!")
  end
end