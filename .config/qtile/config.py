##### IMPORTS #####/

import os
import re
import socket
import subprocess
from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from libqtile.widget import  spacer
from Xlib import display as xdisplay

##### DEFINING SOME WINDOW FUNCTIONS #####

@lazy.function
def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)

@lazy.function
def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)

##### LAUNCH APPS IN SPECIFIED GROUPS #####

def app_or_group(group, app):
    def f(qtile):
        if qtile.groupMap[group].windows:
            qtile.groupMap[group].cmd_toscreen()
        else:
            qtile.groupMap[group].cmd_toscreen()
            qtile.cmd_spawn(app)
    return f

##### KEYBINDINGS #####

def init_keys():
    keys = [
            Key(
                [mod], "Return",
                lazy.spawn(myTerm)                      # Open terminal
                ),
            Key(
                [mod], "Tab",
                lazy.next_layout()                      # Toggle through layouts
                ),
            Key(
                [mod, "shift"], "q",
                lazy.window.kill()                      # Kill active window
                ),
            Key(
                [mod, "shift"], "r",
                lazy.restart()                          # Restart Qtile
                ),
            Key(
                [mod, "mod1"], "q",
                lazy.shutdown()                         # Shutdown Qtile
                ),
            Key([mod], "w",
                lazy.to_screen(1)                       # Keyboard focus screen(0)
                ),
            Key([mod], "e",
                lazy.to_screen(0)                       # Keyboard focus screen(1)
                ),
            Key([mod, "control"], "k",
                lazy.layout.section_up()                # Move up a section in treetab
                ),
            Key([mod, "control"], "j",
                lazy.layout.section_down()              # Move down a section in treetab
                ),
            ### Window controls
            Key(
                [mod], "Right",
                lazy.layout.down()                      # Switch between windows in current stack pane
                ),
            Key(
                [mod], "Left",
                lazy.layout.up()                        # Switch between windows in current stack pane
                ),
            Key(
                [mod, "shift"], "Right",
                lazy.layout.shuffle_down()              # Move windows down in current stack
                ),
            Key(
                [mod, "shift"], "Left",
                lazy.layout.shuffle_up()                # Move windows up in current stack
                ),
            Key(
                [mod, "mod1"], "Right",
                lazy.layout.grow(),                     # Grow size of current window (XmonadTall)
                ),
            Key(
                [mod, "mod1"], "Left",
                lazy.layout.shrink(),                   # Shrink size of current window (XmonadTall)
                ),
            Key(
                [mod], "n",
                lazy.layout.normalize()                 # Restore all windows to default size ratios 
                ),
            Key(
                [mod], "m",
                lazy.layout.maximize()                  # Toggle a window between minimum and maximum sizes
                ),
            Key(
                [mod, "shift"], "Return",
                lazy.window.toggle_floating()           # Toggle floating
                ),
                
            ### Dmenu Run Launcher
            Key(
                [mod, "mod1"], "space",
                lazy.spawn("dmenu_run -fn 'JetBrainsMono Nerd Font:pixelsize=20' -nb '#292d3e' -nf '#bbc5ff' -sb '#82AAFF' -sf '#292d3e' -p 'dmenu:'")
                ),
            Key(
                [mod], "space",
                lazy.spawn("rofi -show drun -eh 2 -opacity 85 -font 'JetBrainsMono Nerd Font 18'")
                 ),
                
            ### My applications launched with SUPER + ALT + KEY
            Key(
                [mod], "F2",
                lazy.spawn("firefox")
                ),
            Key(
                [mod], "F3",
                lazy.spawn("dolphin")
                ),
            Key(
                ["shift"], "Print",
                lazy.spawn("maim ~/Pictures/Screenshot_$(date +%F-%H%M%S).png && notify-send 'Screenshot saved in Pictures folder'")
                ),
            Key(
                [], "Print",
                lazy.spawn("notify-send 'Select screenshot area' && maim --format=png -s /dev/stdout | xclip -selection clipboard -t image/png -i && notify-send 'Image copied to clipboard'")
                ),
            Key(
                [mod], "Print",
                lazy.spawn("notify-send 'Select screenshot area' && maim -s ~/Pictures/Screenshot_$(date +%F-%H%M%S).png && notify-send 'Screenshot saved in Pictures folder'")
                ),
        ]

    return keys

##### BAR COLORS #####

def init_colors():
    return [["#292D3E", "#292D3E"], # panel background
            ["#434758", "#434758"], # background for current screen tab
            ["#D0D0D0", "#D0D0D0"], # font color for group names
            ["#F07178", "#F07178"], # background color for layout widget
            ["#000000", "#000000"], # background for other screen tabs
            ["#AD69AF", "#AD69AF"], # dark green gradiant for other screen tabs
            ["#C3E88D", "#C3E88D"], # background color for network widget
            ["#C792EA", "#C792EA"], # background color for pacman widget
            ["#9CC4FF", "#9CC4FF"], # background color for cmus widget
            ["#000000", "#000000"], # background color for clock widget
            ["#434758", "#434758"]] # background color for systray widget

##### GROUPS #####

def init_group_names():
    return [("1", {'layout': 'monadtall'}),
            ("2", {'layout': 'monadtall'}),
            ("3", {'layout': 'monadtall'}),
            ("4", {'layout': 'monadtall'}),
            ("5", {'layout': 'monadtall'}),
            ("6", {'layout': 'monadtall'}),
            ("MUSIC", {'layout': 'monadtall'}),
            ("CHAT", {'layout': 'monadtall'})]

def init_groups():
    return [Group(name, **kwargs) for name, kwargs in init_group_names()]


##### LAYOUTS #####

def init_floating_layout():
    return layout.Floating(border_focus="#3B4022", float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])

def init_layout_theme():
    return {"border_width": 2,
            "margin": 10,
            "border_focus": "AD69AF",
            "border_normal": "1D2330"
           }

def init_border_args():
    return {"border_width": 2}

def init_layouts():
    return [layout.Max(**layout_theme),
            layout.MonadTall(ratio=0.60,**layout_theme),
            layout.MonadWide(**layout_theme),
            layout.Bsp(**layout_theme),
            layout.Stack(stacks=2, **layout_theme),
            #layout.Columns(**layout_theme),
            #layout.RatioTile(**layout_theme),
            #layout.VerticalTile(**layout_theme),
            #layout.Tile(shift_windows=True, **layout_theme),
            layout.Matrix(**layout_theme),
            #layout.Zoomy(**layout_theme),
            layout.Floating(**layout_theme),
            layout.TreeTab(**layout_theme)]

##### WIDGETS #####

def init_widgets_defaults():
    return dict(font="JetBrainsMono Nerd Font",
                fontsize = 10,
                padding = 2,
                background=colors[2])


def init_left_side_widgets():
    return [
               widget.Sep(
                        linewidth = 0,
                        padding = 6,
                        foreground = colors[2],
                        background = colors[0]
                        ),
               widget.GroupBox(
                        padding_x = 6,
                        borderwidth = 1,
                        active = colors[2],
                        inactive = colors[2],
                        rounded = False,
                        highlight_method = "line",
                        this_current_screen_border = colors[7],
                        this_screen_border = colors [7],
                        other_current_screen_border = colors[2],
                        other_screen_border = colors[2],
                        foreground = colors[2],
                        background = colors[0]
                        ),
               widget.Sep(
                        linewidth = 0,
                        padding = 10,
                        foreground = colors[2],
                        background = colors[0]
                        ),
               widget.WindowName(
                        foreground = colors[5],
                        background = colors[0]
                        )
            ]

def init_right_side_widgets():
    return [
               widget.TextBox(
                        text=" 🕒",
                        foreground=colors[2],
                        background=colors[9],
                        padding = 5,
                        fontsize=14
                        ),
               widget.Clock(
                        foreground = colors[2],
                        background = colors[9],
                        format="%A, %B %d - %H:%M"
                        ),
               widget.Sep(
                        linewidth = 0,
                        padding = 5,
                        foreground = colors[0],
                        background = colors[9]
                        ),
               ]

def init_widgets_list():
    return init_left_side_widgets() + [
               widget.image.Image(
                        scale = True,
                        filename = "~/.config/qtile/bar03-alone.png",
                        background = colors[3]
                        ),
               widget.CurrentLayoutIcon(
                        foreground = colors[0],
                        background = colors[3],
                        padding = 5,
                        scale = 0.6
                        ),
               widget.CurrentLayout(
                        foreground = colors[0],
                        background = colors[3],
                        padding = 5
                        ),
               widget.image.Image(
                        scale = True,
                        filename = "~/.config/qtile/bar07-alone.png",
                        background = colors[9]
                        ),
              ] + init_right_side_widgets()

def init_widgets_list_primary():
    return init_left_side_widgets() + [
                widget.Image(
                        scale = True,
                        filename = "~/.config/qtile/bar06.png",
                        background = colors[6]
                        ),
                widget.Systray(
                        background=colors[10],
                        padding = 5
                        ),
                widget.Image(
                        scale = True,
                        filename = "~/.config/qtile/bar02-b.png",
                        background = colors[6]
                        ),
                widget.TextBox(
                        text=" ↯",
                        foreground=colors[0],
                        background=colors[6],
                        padding = 0,
                        fontsize=14
                        ),
                widget.Battery(
                        foreground = colors[0],
                        background = colors[6],
                        padding = 5,
                        format = '{char} {percent:2.0%}'
                        ),
                widget.Image(
                        scale = True,
                        filename = "~/.config/qtile/bar03.png",
                        background = colors[3]
                        ),
               widget.CurrentLayoutIcon(
                        foreground = colors[0],
                        background = colors[3],
                        padding = 5,
                        scale = 0.6
                        ),
                widget.CurrentLayout(
                        foreground = colors[0],
                        background = colors[3],
                        padding = 5
                        ),
                widget.Image(
                        scale = True,
                        filename = "~/.config/qtile/bar04.png",
                        background = colors[7]
                        ),
                widget.TextBox(
                        text="⌨",
                        padding = 5,
                        foreground=colors[0],
                        background=colors[7],
                        fontsize=14
                        ),
                widget.KeyboardLayout(
                        update_interval = 1,
                        foreground = colors[0],
                        background = colors[7],
                        configured_keyboards = ['it', 'us altgr-intl']
                        ),
                widget.Image(
                        scale = True,
                        filename = "~/.config/qtile/bar05.png",
                        background = colors[8]
                        ),
                widget.TextBox(
                        text=" ♫",
                        padding = 5,
                        foreground=colors[0],
                        background=colors[8],
                        fontsize=14
                        ),
                widget.Mpris2(
                        name='spotify',
                        objname="org.mpris.MediaPlayer2.spotify",
                        display_metadata=['xesam:title', 'xesam:artist'],
                        max_chars = 40,
                        update_interval = 1,
                        scroll_chars=None,
                        stop_pause_text='paused',
                        foreground=colors[0],
                        background = colors[8]
                        ),
                widget.Image(
                        scale = True,
                        filename = "~/.config/qtile/bar07.png",
                        background = colors[9]
                        ),
              ] + init_right_side_widgets()

# this import requires python-xlib to be installed


def get_num_monitors():
    num_monitors = 0
    try:
        display = xdisplay.Display()
        screen = display.screen()
        resources = screen.root.xrandr_get_screen_resources()

        for output in resources.outputs:
            monitor = display.xrandr_get_output_info(output, resources.config_timestamp)
            preferred = False
            if hasattr(monitor, "preferred"):
                preferred = monitor.preferred
            elif hasattr(monitor, "num_preferred"):
                preferred = monitor.num_preferred
            if preferred:
                num_monitors += 1
    except Exception as e:
        # always setup at least one monitor
        return 1
    else:
        return num_monitors

def init_screens():
    num_monitors = get_num_monitors()
    ret_screens = [Screen(top=bar.Bar(widgets=init_widgets_list_primary(), opacity=0.95, size=24))]

    if num_monitors > 1:
        for m in range(num_monitors - 1):
            ret_screens.append(
                Screen(
                    top=bar.Bar(widgets=init_widgets_list(),
                        size=24,
                        opacity=0.95,
                    ),
                )
            )
    return ret_screens

##### FLOATING WINDOWS #####

@hook.subscribe.client_new
def floating(window):
    floating_types = ['notification', 'toolbar', 'splash', 'dialog']
    transient = window.window.get_wm_transient_for()
    if window.window.get_wm_type() in floating_types or transient:
        window.floating = True

@hook.subscribe.client_new
def class_to_group(client):
    apps = {'microsoft teams - preview': 'CHAT', 'skype': 'CHAT',"slack": 'CHAT','spotify': 'MUSIC'}
    wm_class = client.window.get_wm_class()[0]
    group = apps.get(wm_class, None)
    if group:
        client.togroup(group)

@hook.subscribe.client_new
def name_to_group(client):
    apps = {"mutt": 'CHAT'}
    wm_name = client.name
    group = apps.get(wm_name, None)
    if group:
        client.togroup(group)

def init_mouse():
    return [Drag([mod], "Button1", lazy.window.set_position_floating(),      # Move floating windows
                 start=lazy.window.get_position()),
            Drag([mod], "Button3", lazy.window.set_size_floating(),          # Resize floating windows
                 start=lazy.window.get_size()),
            Click([mod, "shift"], "Button1", lazy.window.bring_to_front())]  # Bring floating window to front

def move_and_follow(name):
    lazy.window.togroup(name)
    lazy.group[name].toscreen()


##### DEFINING A FEW THINGS #####

if __name__ in ["config", "__main__"]:
    mod = "mod4"                                     # Sets mod key to SUPER/WINDOWS
    myTerm = "termite"                                    # My terminal of choice
    myConfig = "/home/mua/.config/qtile/config.py"    # Qtile config file location 
    
    follow_mouse_focus = True
    colors = init_colors()
    keys = init_keys()
    mouse = init_mouse()
    groups = init_groups()
    screens = init_screens()
    
    floating_layout = init_floating_layout()
    layout_theme = init_layout_theme()
    border_args = init_border_args()
    layouts = init_layouts()
    
    widget_defaults = init_widgets_defaults()

    ##### SETS GROUPS KEYBINDINGS #####

    for i, (name, kwargs) in enumerate(init_group_names(), 1):
        keys.append(Key([mod], str(i), lazy.group[name].toscreen()))          # Switch to another group
        keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(name)))   # Send current window to another group
        keys.append(Key([mod, "control"], str(i), move_and_follow(name)))


##### STARTUP APPLICATIONS #####

@hook.subscribe.screen_change
def restart_on_randr(ev):
    subprocess.call(["notify-send", "'screen change'"])
    subprocess.call(["nitrogen", "--restore"])
    libqtile.qtile.cmd_restart()

@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])

##### NEEDED FOR SOME JAVA APPS #####

wmname = "LG3D"
#wmname = "qtile"
