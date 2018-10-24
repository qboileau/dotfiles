
import os
from subprocess import call
#
call2 = os.system("xrandr | grep \" connected \" | grep -oP \"^([\\w-]*)\s\"")
print(call2)

# print("####################3")
# call1 = call(["xrandr"])
#
# print(call1)
