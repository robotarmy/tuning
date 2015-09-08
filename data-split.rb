
#
# un verified
# http://www.romraider.com/forum/viewtopic.php?f=8&t=8475&start=15
# CAN ID 0x18 - Byte 0 and 1: Steering Angle
# CAN ID 0x140 - Byte 0, 4, 5: TPS (all 3 bytes display the same value)
# CAN ID 0x140 - Byte 2 and 3: RPM
#
#
#


# negotiate baud
#
# 010801
#
# Enable logging
#
# 030101
#
# Disable Logging
#
# 030100
#
#
# Test Capture Procedure
# Disconnect USB from laptop
# Plug in OBD2 cable to CANBUS Tripple
# Start Car - let car settle
# Plug in OBD2 cable to car
# Plug in USB to laptop
# Connect vi CoolTerm
# # negotiate Baud in CoolTerm by sending Hex Codes
# # 010801
# # turn on logging in coolterm by sending hex codes
# # 030101
# note - passenger seatbelt warning was on for most of these steps
# Hill start assist out of driveway
# turn right down street
# go to stop sign, stop
# accellerate in 1st not higher that 3000rpm
# accelerate in  2nd quick and shift between 3200rpm-4000rpm into 3rd ( boost ok)
# foot off throttle, coast in 3rd
# shift to 4th
# before daves rev match to 3rd and then to 2nd, at moderate engine speed
# turn right carefully at light
# up hill, in 2nd gear between 2000-3000rpm - no boost
# cruise down street no more that 2000prm
# at street intersection rev match to 1st and
# coast down hill
# come to a stop just after driveway on right side road below 4 IVY driveways.
# # turn off data logger.
#
# # run #2
# # repeat from parking location without hillstart
# 
# # run #3
# # repeat from parked location without hillstart and without laptop on seat ( no passenger warning)


#curtis:Tuning/ $ cat 2015-SubaruSTI-Capture-Idle.txt| awk -F, '{print $4}' | sort | uniq  > 2015-SubaruSTI-Capture-Idle-UniqueCodes.txt
#
require 'FileUtils'
codes = ARGV[0] or (puts "no unique code file given"; exit)
data  = ARGV[1] or (puts "no data file"; exit)

dirname =  "data-split-by-id-#{File.basename(data)}"
FileUtils.mkdir_p dirname
IO.foreach(codes) do |line|
  if line =~ (/\"id\"\:\"(\w+)\"/)
     canid =  $1
    `cat #{data}| grep '"id":"#{canid}"' > #{File.join(dirname,canid)}.json`
  end
end
