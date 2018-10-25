# Dependency python-xlib

import os
import subprocess

from Xlib import X, display
from Xlib.ext import randr
import pprint


class Output:
    def __init__(self, id, name, isPrimary, isConnected, modes):
        self.id = id
        self.name = name
        self.isPrimary = isPrimary
        self.isConnected = isConnected
        self.modes = modes

    def to_string(self):
        string = f"{self.name} ({self.id}) primary:{self.isPrimary} connected:{self.isConnected}\n"
        for mode in self.modes:
            string += "     " + mode.to_string() + "\n"
        return string


class Mode:
    def __init__(self, id, width, height, preferred):
        self.id = id
        self.width = width
        self.height = height
        self.preferred = preferred

    def to_string(self):
        return f"{self.id} {self.width}x{self.height} preferred:{self.preferred}"


def execute_to_list(str):
    items = subprocess.getoutput(str).split("\n")
    return set(map(lambda x: x.strip(), items))

def sanitized(str):
    return str.replace("-", "_")

def outputs_off(monitors):
    off = ''
    for monitor in monitors:
        off +=f' --output {monitor.name} --off'
    return off

def generate_monitor_config(outputs):

    try:
        primary = next(filter(lambda o: o.isPrimary, outputs))
    except StopIteration:
        primary = next(outputs)

    config = ''
    config += 'bindsym $mod+F6 mode $monitor_mode\n'
    mode_desc = 'set $monitor_mode'

    # generate variables
    for i, monitor in enumerate(outputs):
        other_on = [x for x in set(outputs) if x != monitor and x.isConnected]

        # TODO rebuild an reload i3 configuration
        c_off = f'xrandr --output {monitor.name} --off'
        c_primary = f'xrandr --output {monitor.name} --primary'
        c_alone = f'xrandr --output {monitor.name} --primary --auto {outputs_off(other_on)}'
        c_left_primary = f'xrandr --output {monitor.name} --auto --left-of {primary.name}'
        c_right_primary = f'xrandr --output {monitor.name} --auto --right-of {primary.name}'

        cmds = []
        cmds.append(("[a]lone", f'   bindsym a exec "{c_alone}", mode "default"\n'))
        if monitor.isConnected and len(other_on) > 0:
            cmds.append(("[o]ff", f'   bindsym o exec "{c_off}", mode "default"\n'))

        if not monitor.isPrimary:
            cmds.append(("[p]rimary", f'   bindsym p exec "{c_primary}", mode "default"\n'))
            cmds.append((f"Left[←] of {primary.name}", f'   bindsym Left exec "{c_left_primary}", mode "default"\n'))
            cmds.append((f"Right[→] of {primary.name}", f'   bindsym Right exec "{c_right_primary}", mode "default"\n'))

        orientation_desc = ", ".join(map(lambda c: c[0], cmds))
        config += f'set ${sanitized(monitor.name)} {monitor.name} {orientation_desc}\n'
        config += f'mode "${sanitized(monitor.name)}"' + " {\n"
        for cmd in cmds:
            config += cmd[1]

        config += '   bindsym Return mode "default"\n'
        config += '   bindsym Escape mode "default"\n'
        config += '}\n\n'
        if monitor.isPrimary:
            mode_desc += f' {monitor.name}*({i+1})'
        else :
            mode_desc += f' {monitor.name}({i+1})'

    config += mode_desc+'\n'
    config += 'mode "$monitor_mode" {\n'
    for i, monitor in enumerate(outputs):
        config += f'    bindsym {i+1} mode "${sanitized(monitor.name)}"\n'

    config += '    bindsym Return mode "default"\n'
    config += '    bindsym Escape mode "default"\n'
    config += '}\n'

    return config


def get_config():
    opt_primary = execute_to_list("xrandr | grep \" connected \" | grep \"primary\" | grep -oP \"^([\\w-]*)\s\"")
    monitors_connected = execute_to_list("xrandr | grep \" connected \" | grep -oP \"^([\\w-]*)\s\"")
    monitors_disconnected = execute_to_list("xrandr | grep \" disconnected \" | grep -oP \"^([\\w-]*)\s\"")

    all_monitors = monitors_connected.union(monitors_disconnected)

    outputs = []
    for monitor in all_monitors:
        primary = True if (monitor in opt_primary) else False
        connected = True if (monitor in monitors_connected) else False
        outputs.append(Output(monitor, monitor, primary, connected, []))

    return list(reversed(sorted(outputs, key=lambda o: (o.isPrimary, o.name))))



def parseModes(mode_names, modes):
    lastIdx = 0
    modedatas = dict()
    for mode in modes:
        modedata = dict(mode._data)
        modedata['name'] = mode_names[lastIdx:lastIdx + modedata['name_length']]
        modedatas[modedata['id']] = modedata
        lastIdx += modedata['name_length']
    return modedatas


def map_modes(output_modes, mode_list, index_preferred):
    modes = []
    if len(output_modes) > 0:
        preferred_mode = output_modes[index_preferred-1]
        for i, mode in enumerate(mode_list):
            if mode.id in output_modes:
                id = mode.id
                width = mode.width
                height = mode.height
                preferred = True if (mode.id == preferred_mode) else False
                modes.append(Mode(id, width, height, preferred))

    return modes

def get_outputs(window, d):
    outputs=[]
    resources = window.xrandr_get_screen_resources()._data
    primary = window.xrandr_get_output_primary().output
    modes_list = resources['modes']
    for output in resources['outputs']:
        id = int("%d" % (output, ))
        output_info = d.xrandr_get_output_info(output, resources['config_timestamp'])
        name = output_info.name
        is_primary = True if (primary == id) else False
        is_connected = True if (output_info.connection == 0) else False
        num_preferred = output_info.num_preferred
        output_modes = map_modes(output_info.modes, modes_list, num_preferred)

        outputs.append(Output(id, name, is_primary, is_connected, output_modes))

    return list(reversed(sorted(outputs, key=lambda o: (o.isPrimary, o.name))))

pp = pprint.PrettyPrinter(indent=4)
d = display.Display()
s = d.screen()
window = s.root.create_window(0, 0, 1, 1, 1, s.root_depth)

outputs = get_outputs(window, d)

#generate and print config
config = generate_monitor_config(outputs)
print(config)

#
#
# print("Primary output:")
# pp.pprint(window.xrandr_get_output_primary()._data)
#
# resources = window.xrandr_get_screen_resources()._data
# print("Modes:")
#
# for mode in resources['modes']:
#     # print("Mode %d info:" % (mode, ))
#     pp.pprint(mode._data)
#
# for mode_id, mode in parseModes(resources['mode_names'], resources['modes']).items():
#     print("    %d: %s" % (mode_id, mode['name']))
#
# for output in resources['outputs']:
#     print("Output %d info:" % (output, ))
#     pp.pprint(d.xrandr_get_output_info(output, resources['config_timestamp'])._data)
#
# for crtc in resources['crtcs']:
#     print("CRTC %d info:" % (crtc, ))
#     pp.pprint(d.xrandr_get_crtc_info(crtc, resources['config_timestamp'])._data)
#
# print("Screen info:")
# pp.pprint(window.xrandr_get_screen_info()._data)
#
# print("Screen size range:")
# pp.pprint(window.xrandr_get_screen_size_range()._data)
#
#
# for output in outputs:
#     print(f"Output {output.to_string()}")