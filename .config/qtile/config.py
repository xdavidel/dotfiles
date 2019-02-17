##### IMPORTS #####

import os
import re
import socket
import subprocess
from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from libqtile.widget import Spacer

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
                lazy.spawn(myTerm)                        # Open terminal
                ),
            Key(
                [mod], "Tab",
                lazy.next_layout()                        # Toggle through layouts
                ),
            Key(
                [mod], "q",
                lazy.window.kill()                        # Kill active window
                ),
            Key(
                [mod, "shift"], "r",
                lazy.restart()                            # Restart Qtile
                ),
            Key(
                [mod, "shift"], "Escape",
                lazy.shutdown()                           # Shutdown Qtile
                ),
            Key([mod], "i",
                lazy.to_screen(2)                         # Keyboard focus screen(0)
                ),
            Key([mod], "o",
                lazy.to_screen(0)                         # Keyboard focus screen(1)
                ),
            Key([mod], "p",
                lazy.to_screen(1)                         # Keyboard focus screen(2)
                ),
            Key([mod, "control"], "k",
                lazy.layout.section_up()                          # Move up a section in treetab
                ),
            Key([mod, "control"], "j",
                lazy.layout.section_down()                        # Move down a section in treetab
                ),
            # Window controls
            Key(
                [mod], "k",
                lazy.layout.down()                        # Switch between windows in current stack pane
                ),
            Key(
                [mod], "j",
                lazy.layout.up()                          # Switch between windows in current stack pane
                ),
            Key(
                [mod, "shift"], "k",
                lazy.layout.shuffle_down()                # Move windows down in current stack
                ),
            Key(
                [mod, "shift"], "j",
                lazy.layout.shuffle_up()                  # Move windows up in current stack
                ),
            Key(
                [mod, "shift"], "l",
                lazy.layout.grow(),                       # Grow size of current window (XmonadTall)
                lazy.layout.increase_nmaster(),           # Increase number in master pane (Tile)
                ),
            Key(
                [mod, "shift"], "h",
                lazy.layout.shrink(),                     # Shrink size of current window (XmonadTall)
                lazy.layout.decrease_nmaster(),           # Decrease number in master pane (Tile)
                ),
            Key(
                [mod, "shift"], "Left",                   # Move window to workspace to the left
                window_to_prev_group
                ),
            Key(
                [mod, "shift"], "Right",                  # Move window to workspace to the right
                window_to_next_group
                ),
            Key(
                [mod], "n",
                lazy.layout.normalize()                   # Restore all windows to default size ratios 
                ),
            Key(
                [mod], "m",
                lazy.layout.maximize()                    # Toggle a window between minimum and maximum sizes
                ),
            Key(
                [mod, "shift"], "KP_Enter",
                lazy.window.toggle_floating()             # Toggle floating
                ),
            Key(
                [mod, "shift"], "space",
                lazy.layout.rotate(),                     # Swap panes of split stack (Stack)
                lazy.layout.flip()                        # Switch which side main pane occupies (XmonadTall)
                ),
            # Stack controls
            Key(
                [mod], "space",
                lazy.layout.next()                        # Switch window focus to other pane(s) of stack
                ),
            Key(
                [mod, "control"], "Return",
                lazy.layout.toggle_split()                # Toggle between split and unsplit sides of stack
                ),
            # GUI Apps

            Key(
                [mod], "d",
                lazy.spawn("dmenu_run")
                ),
            Key(
                [mod], "g",
                lazy.spawn("geany")
                ),
           
        ]
    return keys

##### BAR COLORS #####

def init_colors():
    return [["#1D2330", "#1D2330"], # panel background
            ["#84598D", "#84598D"], # background for current screen tab
            ["#B1B5C8", "#B1B5C8"], # font color for group names
            ["#645377", "#645377"], # background color for layout widget
            ["#000000", "#000000"], # background for other screen tabs
            ["#AD69AF", "#AD69AF"], # dark green gradiant for other screen tabs
            ["#7B8290", "#7B8290"], # background color for network widget
            ["#AD69AF", "#AD69AF"], # background color for pacman widget
            ["#357FC5", "#357FC5"], # background color for cmus widget
            ["#000000", "#000000"], # background color for clock widget
            ["#84598d", "#84598d"]] # background color for systray widget

##### GROUPS #####

def init_group_names():
    return [("DEV", {'layout': 'max'}),
            ("WWW", {'layout': 'max'}),
            ("SYS", {'layout': 'monadtall'}),
            ("DOC", {'layout': 'monadtall'}),
            ("VBOX", {'layout': 'monadtall'}),
            ("CHAT", {'layout': 'bsp'}),
            ("MEDIA", {'layout': 'monadtall'}),
            ("GFX", {'layout': 'monadtall'})]

def init_groups():
    return [Group(name, **kwargs) for name, kwargs in group_names]


##### LAYOUTS #####

def init_floating_layout():
    return layout.Floating(border_focus="#3B4022")

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
            layout.MonadTall(**layout_theme),
            layout.MonadWide(**layout_theme),
            layout.Bsp(**layout_theme),
            layout.Slice(side="left", width=192, name="gimp", role="gimp-toolbox",
                fallback=layout.Slice(side="right", width=256, role="gimp-dock",
                fallback=layout.Stack(num_stacks=1, **border_args))),
            #layout.Stack(stacks=2, **layout_theme),
            #layout.Columns(**layout_theme),
            #layout.RatioTile(**layout_theme),
            #layout.VerticalTile(**layout_theme),
            #layout.Tile(shift_windows=True, **layout_theme),
            #layout.Matrix(**layout_theme),
            #layout.Zoomy(**layout_theme),
			]

##### WIDGETS #####

def init_widgets_defaults():
    return dict(font="Ubuntu Mono",
                fontsize = 11,
                padding = 2,
                background=colors[2])

def init_widgets_list():
    prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())
    widgets_list = [
               widget.Sep(
                        linewidth = 0,
                        padding = 6,
                        foreground = colors[2],
                        background = colors[0]
                        ),
               widget.GroupBox(font="Ubuntu Bold",
                        fontsize = 9,
                        margin_y = 0,
                        margin_x = 0,
                        padding_y = 9,
                        padding_x = 5,
                        borderwidth = 1,
                        active = colors[2],
                        inactive = colors[2],
                        rounded = False,
                        highlight_method = "block",
                        this_current_screen_border = colors[1],
                        this_screen_border = colors [4],
                        other_current_screen_border = colors[0],
                        other_screen_border = colors[0],
                        foreground = colors[2],
                        background = colors[0]
                        ),
               widget.Prompt(
                        prompt=prompt,
                        font="Ubuntu Mono",
                        padding=10,
                        foreground = colors[3],
                        background = colors[1]
                        ),
               widget.Sep(
                        linewidth = 0,
                        padding = 10,
                        foreground = colors[2],
                        background = colors[0]
                        ),
               widget.WindowName(font="Ubuntu",
                        fontsize = 11,
                        foreground = colors[5],
                        background = colors[0],
                        padding = 6
                        ),
               widget.Image(
                        scale = True,
                        filename = "~/.config/qtile/bar06.png",
                        background = colors[6]
                        ),
               widget.Systray(
                        background=colors[10],
                        padding = 6
                        ),
               widget.Image(
                        scale = True,
                        filename = "~/.config/qtile/bar02-b.png",
                        background = colors[6]
                        ),
               widget.Volume(
                        scale = True,
                        filename = "~/.config/qtile/bar02-b.png",
                        background = colors[6],
                        padding = 6,
						fontsize=14,
                        ),   
               widget.TextBox(
                        font="Ubuntu Bold",
                        text="🔉",
                        padding = 6,
                        foreground = colors[2],
                        background=colors[6],
                        fontsize=14
                        ),
               widget.Image(
                        scale = True,
                        filename = "~/.config/qtile/bar03.png",
                        background = colors[3]
                        ),
               widget.CurrentLayoutIcon(
						font="Ubuntu Bold",
						background=colors[3],
						padding = 6,
						fontsize=14,
						scale=0.8,
               ),
               widget.CurrentLayout(
                        foreground = colors[2],
                        background = colors[3],
                        padding = 6
                        ),
               widget.Image(
                        scale = True,
                        filename = "~/.config/qtile/bar04.png",
                        background = colors[7]
                        ),
               widget.TextBox(
                        font="Ubuntu Bold",
                        text=" ⟳",
                        padding = 6,
                        foreground=colors[0],
                        background=colors[7],
                        fontsize=14
                        ),
               widget.Pacman(
                        execute = "st -e sudo pacman -Syu",
                        update_interval = 1800,
                        foreground = colors[0],
                        background = colors[7]
                        ),
               widget.TextBox(
                        text="Updates",
                        padding = 6,
                        foreground=colors[0],
                        background=colors[7]
                        ),
               widget.Image(
                        scale = True,
                        filename = "~/.config/qtile/bar05.png",
                        background = colors[8]
                        ),
               widget.TextBox(
                        font="Ubuntu Bold",
                        text=" ♫",
                        padding = 6,
                        foreground = "d7d7d7",
                        background=colors[8],
                        fontsize=14
                        ),
               widget.Cmus(
                        max_chars = 40,
                        update_interval = 0.5,
                        foreground = "d7d7d7",
                        background = colors[8]
                        ),
               widget.Image(
                        scale = True,
                        filename = "~/.config/qtile/bar07.png",
                        background = colors[9]
                        ),
               widget.TextBox(
                        font="Ubuntu Bold",
                        text=" 🕒",
                        foreground=colors[2],
                        background=colors[9],
                        padding = 6,
                        fontsize=14
                        ),
               widget.Clock(
                        foreground = colors[2],
                        background = colors[9],
                        format="%A, %B %d - %H:%M"
                        ),
               widget.Sep(
                        linewidth = 0,
                        padding = 6,
                        foreground = colors[0],
                        background = colors[9]
                        ),
              ]
    return widgets_list

##### SCREENS ##### (TRIPLE MONITOR SETUP)

def init_widgets_screen():
    widgets_screen = init_widgets_list()
    return widgets_screen

def init_screens():
    return [Screen(top=bar.Bar(widgets=init_widgets_screen(), opacity=0.95, size=25))]

##### FLOATING WINDOWS #####

@hook.subscribe.client_new
def floating(window):
    floating_types = ['notification', 'toolbar', 'splash', 'dialog']
    transient = window.window.get_wm_transient_for()
    if window.window.get_wm_type() in floating_types or transient:
        window.floating = True

def init_mouse():
    return [Drag([mod], "Button1", lazy.window.set_position_floating(),      # Move floating windows
                 start=lazy.window.get_position()),
            Drag([mod], "Button3", lazy.window.set_size_floating(),          # Resize floating windows
                 start=lazy.window.get_size()),
            Click([mod, "shift"], "Button1", lazy.window.bring_to_front())]  # Bring floating window to front

##### DEFINING A FEW THINGS #####

if __name__ in ["config", "__main__"]:
    mod = "mod4"                                         # Sets mod key to SUPER/WINDOWS
    myTerm = "st"                                    # My terminal of choice

    colors = init_colors()
    keys = init_keys()
    mouse = init_mouse()
    group_names = init_group_names()
    groups = init_groups()
    floating_layout = init_floating_layout()
    layout_theme = init_layout_theme()
    border_args = init_border_args()
    layouts = init_layouts()
    screens = init_screens()
    widget_defaults = init_widgets_defaults()
    widgets_list = init_widgets_list()
    widgets_screen = init_widgets_screen()

##### SETS GROUPS KEYBINDINGS #####

for i, (name, kwargs) in enumerate(group_names, 1):
    keys.append(Key([mod], str(i), lazy.group[name].toscreen()))          # Switch to another group
    keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(name)))   # Send current window to another group

##### STARTUP APPLICATIONS #####

@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])

##### NEEDED FOR SOME JAVA APPS #####

#wmname = "LG3D"
wmname = "qtile"
