-- ===================================== --
-- config for Time Lapse Mod (by MrP123) --
-- ===================================== --

-- disclaimers:
-- if part of the area of the screenshot isn't loaded yet it will be black
-- if the area of the game that is on one screenshot is too big everything that is far away from the player will look very bad, this only happens if centerOnPlayerCFG is enabled

-- this is the time difference in seconds between screenshots. This time difference isn't really accurate, as the amount of ticks per second vary depending on if the hardware is able to keep up with the game
-- default: 300 which equals 5 minutes
timeDifferenceCFG = 300

-- this is the amount of ticks per second; default: 60 for vanilla Factorio, but if any other mod changes the amount of ticks per second this will have to be changed accordingly or your timing will be off
ticksPerSecondCFG = 60

-- if this option is set to "true" the game time will be changed shortly while taking a screenshot so all screenshots are taken at noon; default: false
onlyDayScreenshotsCFG = false

-- if this option is set to "true" a message will be printed whenever a screenshot is taken
printMessageCFG = false

-- if this option is enabled all screenshots will be taken at the position of the player; centerOnPlayerCFG and centerOnPositionCFG can't be active at the same time;
centerOnPlayerCFG = true

-- if this option is enabled all screenshots will be taken at the specified positon; centerOnPlayerCFG and centerOnPositionCFG can't be active at the same time; default: false; { 0, 0 }
centerOnPositionCFG = false
positionCFG = { 0, 0 }	-- if the area at this position isn't loaded the screenshot will be black

-- this is the resolution of the resulting screenshots; default: { 1920, 1080 }
resolutionCFG = { 1920, 1080 }

-- this is the zoom factor of the resulting screenshots (as a double value > 0); default: 1
zoomCFG = 1

-- this is the directory inside the script-output directory of the resulting screenshots; the name of the screenshot will be appended to the end like this "script-output/TimeLapseMod/screenshotname.png"; default: "TimeLapseMod"
pathCFG = "TimeLapseMod"

-- name of the screenshots; default: "screenshot"
screenshotnameCFG = "screenshot"

-- if enabled the GUI of the game will be visible on the screenshots; default: false
showguiCFG = false

-- if enabled the Entity Info will be visible on the screenshots; default: false
showentityinfoCFG = false

-- ======================================= --
-- commands for Time Lapse Mod (by MrP123) --
-- ======================================= --

-- if centerOnPositionCFG is enabled you can set the current position to the player location with this command; this will NOT change the position in the config file and will therefore only work for the CURRENT session
-- /c remote.call("TLM_commands", "setPositionPlayer")

-- if centerOnPositionCFG is enabled you can set the current position to the a specified location with this command; this will NOT change the position in the config file and will therefore only work for the CURRENT session
-- /c remote.call("TLM_commands", "setPositionXY", Your_X_Value_Here, Your_Y_Value_Here) -- for example: /c remote.call("TLM_commands", "setPositionXY", 10, 10)