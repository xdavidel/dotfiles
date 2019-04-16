from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook

import subprocess

# Startup Scripts
def execute_once(process):
    return subprocess.Popen(process.split())

@hook.subscribe.startup
def startup():
    #execute_once('feh --bg-scale /home/thava/Images/wallpaper.jpg')
    #execute_once('/usr/bin/nm-applet')
    #execute_once('/usr/bin/pamac-tray')
    #execute_once('/usr/bin/blueman-applet')
    #execute_once('/usr/bin/dropbox')
    #execute_once('/usr/bin/utox')
    #execute_once('/usr/bin/dunst')
    #execute_once('/usr/bin/light-locker')
    #execute_once('/home/jv/Develop/bin/screentemp')
    pass

mod = "mod4" # Super key
alt = "mod1"

keys = [
    # Switch between windows in current stack pane
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "l", lazy.layout.right()),
    Key([mod], "Left", lazy.layout.left()),
    Key([mod], "Down", lazy.layout.down()),
    Key([mod], "Up", lazy.layout.up()),
    Key([mod], "Right", lazy.layout.right()),

    # Grow / Shrink Monad
    Key([mod, alt], "Right", lazy.layout.grow()),
    Key([mod, alt], "Left", lazy.layout.shrink()),

    # Move windows up or down in current stack
    Key([mod, "shift"], "k", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "Right", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "Left", lazy.layout.shuffle_up()),

    # Switch window focus to other pane(s) of stack
    Key([mod], "space", lazy.layout.next()),

    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate()),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split()),
    Key([mod], "Return", lazy.spawn("st")),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod], "q", lazy.window.kill()),

    Key([mod, "shift"], "r", lazy.restart()),
    Key([mod, "shift"], "F2", lazy.restart()),
    Key([mod, "shift"], "Escape", lazy.shutdown()),
    Key([mod], "r", lazy.spawncmd()),
    Key([mod], "d", lazy.spawn("rofi -show run")),
]

groups = [Group(i) for i in "12345678"]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen()),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name)),
    ])

layout_theme = {
        "border_width": 2,
        "margin" : 10,
        "border_focus" : "AD69AF",
        "border_normal" : "1D2330" 
    }

layouts = [
    layout.Max(**layout_theme),
    layout.MonadTall(**layout_theme),
]

widget_defaults = dict(
    font='sans',
    fontsize=16,
    padding=3,
)

default_configuration1 = dict(
    fontsize=12,
    foreground="FFFFFF",
    background=["33393B", "232729"],
    font="ttf-droid",
    margin_y=2,
    font_shadow="000000",
)

default_configuration2 = dict(
    fontsize=12,
    foreground="FFFFFF",
    background=["232729", "292A2A"],
    font="ttf-droid",
    margin_y=2,
    font_shadow="000000",
)

group_configuration = dict(
    active="db8843",
    inactive="3160aa",
    fontsize=15,
    background=["33393B", "232729"],
    font="ttf-droid",
    margin_y=0,
    font_shadow="000000",
    rounded=False,
    this_current_screen_border='85678F',
    #this_screen_border='3b3a7c',
    highlight_method='block',
    hide_unused=True,
)

extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.TextBox(text="◤ ", fontsize=60, padding=-5, foreground=["232729", "292A2A"], background=["33393B", "232729"]),
                widget.GroupBox(**group_configuration),
                widget.Prompt(**default_configuration1),
                widget.TextBox(text="◤ ", fontsize=60, padding=-5, foreground=["33393B", "232729"], background=["232729", "292A2A"]),
                widget.WindowName(**default_configuration2),
                widget.TextBox(text="◤ ", fontsize=60, padding=-5, foreground=["232729", "292A2A"], background=["33393B", "232729"]),
                widget.TextBox(text="CPU", **default_configuration1),
                widget.CPUGraph(core="all", frequency=5, line_width=2, border_width=1, background=["33393B", "232729"]),
                widget.TextBox(text="  VOL", **default_configuration1),
                widget.Volume(channel="Master", background=["33393B", "232729"]),
                widget.Systray(**default_configuration1),
                widget.TextBox(text="", **default_configuration1),
                widget.TextBox(text="◤ ", fontsize=60, padding=-5, foreground=["33393B", "232729"], background=["232729", "292A2A"]),
                widget.Clock(**default_configuration2, format='%H:%M - %a,%d.%m.%Y'),
                widget.TextBox(text="◤ ", fontsize=60, padding=-5, foreground=["232729", "292A2A"], background=["33393B", "232729"]),
            ],

            26,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = [] 
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
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
auto_fullscreen = True
focus_on_window_activation = "smart"

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, github issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
