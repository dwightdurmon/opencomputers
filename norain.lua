-- This program checks the weather and turns off rain.
--
-- If the signal is on, then the program runs the command to stop the rain.
-- Note: You'll need the Debug Card from creative mode.

-- OpenComputer stack is set up as follows:
-- [Computer][Debug Card]
-- [Screen]
-- [Disk Drive]
-- [Floor]

local keyboard = require("keyboard")
local debug = require("component").debug
local gpu = require("component").gpu
local status

gpu.setResolution(24,10)

while not keyboard.isKeyDown(keyboard.keys.space)
do
  if debug.isRaining() then
    status = "Raining"
    debug.setRaining(false)
  else
    status = "Clear"
  end
  gpu.set(1,1,"Weather Automation System")
  gpu.set(1,3,"Weather   : " .. status)
  gpu.set(1,6,"Press [Space] to exit")

  os.sleep(5)
end

gpu.setResolution(80,25)

-- End