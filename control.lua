require "util"
require "defines"
require "config"

game.on_init(function()
  global.tickCounter = 0
  global.amount = 0
  global.time = -1
  global.shouldUpdate = false

  remote.add_interface("TLM_commands", {
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

game.on_event(defines.events.on_tick, function(event)
  if global.shouldUpdate then
    restoreTime()
    global.time = -1
    global.shouldUpdate = false
  end

  global.tickCounter = global.tickCounter + 1
	if global.tickCounter / (ticksPerSecondCFG * game.speed) > timeDifferenceCFG then	-- this counter is necessary as the lua in Factorio doesn't have access to any libraries, so I can't keep track of time in any other way
		global.tickCounter = 0
		global.amount = global.amount + 1

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

      local pathName = genPathName(pathCFG, screenshotnameCFG, global.amount)
      game.take_screenshot{resolution = resolutionCFG, zoom = zoomCFG, path = pathName, showguiCFG, showentityinfoCFG}
      printMessage()
    elseif centerOnPositionCFG then
      makeNoon()

      local pathName = genPathName(pathCFG, screenshotnameCFG, global.amount)
      game.take_screenshot{position = positionCFG, resolution = resolutionCFG, zoom = zoomCFG, path = pathName, showguiCFG, showentityinfoCFG}
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
    global.time = game.daytime
    game.daytime = 0
    global.shouldUpdate = true
  else
    global.time = -1
  end
end

function restoreTime()
  if global.time ~= -1 then
    game.daytime = global.time
  end
end

function printMessage()
  if printMessageCFG and centerOnPlayerCFG then
    game.player.print("screenshot taken on player!")
  elseif printMessageCFG and centerOnPositionCFG then
    game.player.print("screenshot taken on positon!")
  end
end