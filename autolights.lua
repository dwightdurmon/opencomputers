-- This program sets the Redstone signal (Project Red)
-- to the cable connected to the top of the computer.
-- - At 6AM (06:00) in-game time, the signal is set to 0 (off)
-- - At 6PM (18:00) in-game time, the signal is set to 255 (max on for Project Red)

-- If connected to lights or a wireless transmitter, this will automatically turn them on or off.
-- Note: A chunk loader should be used in your command center to keep the computer running.

-- In-game timing:
-- - Sunset is approximately at 18:30 (6:30PM)
-- - Sunrise 05:30 (5:30AM)

-- OpenComputer stack is set up as follows:
-- [Wireless Transmitter]
-- [Cable]
-- [Computer]
-- [Screen]
-- [Disk Drive]
-- [Floor]
local keyboard = require("keyboard")
local component = require("component")
local sides = require("sides")
local gpu = component.gpu
local w, h = gpu.getResolution()
local rs = component.redstone
local status
local currenttime
local signal

gpu.setResolution(24,10)

while not keyboard.isKeyDown(keyboard.keys.space)
do
  gpu.fill(1, 1, w, h, " ") -- clears the screen
  currenttime = tonumber(os.date("%H"))
  signal = rs.getOutput(sides.top)


  if signal == 0 then
    status = "off"
  else
    status = "on"
  end

  if currenttime < 6 or currenttime >= 18 then
    rs.setOutput(sides.top,255)
  end

  if currenttime >= 6 and currenttime < 18 then
    rs.setOutput(sides.top,0)
  end

  gpu.set(1,1,"Light Automation System")
  gpu.set(1,2,"Current Hour   : " .. currenttime)
  gpu.set(1,3,"Light Status   : " .. status)
  gpu.set(1,4,"Signal Strength: " .. signal)

  os.sleep(1)
end