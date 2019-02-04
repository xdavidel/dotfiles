
from libqtile.config import Key, Screen, Group, Match, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook

import os
import subprocess

try:
    from typing import List  # noqa: F401
except ImportError:
    pass

mod = "mod4"

@hook.subscribe.startup_once
def autostart():
    start_file = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.call([start_file])

keys = [
    # Switch between windows in current stack pane
    Key([mod], "k", lazy.layout.down()),
    Key([mod], "j", lazy.layout.up()),

    # Change layout size
    Key([mod], "i", lazy.layout.grow()),
    Key([mod], "m", lazy.layout.shrink()),

    # toggle floating
    Key([mod], "f", lazy.window.toggle_floating()),

    # Size
    Key([mod, "shift"], "Right", lazy.layout.increase_ratio()),
    Key([mod, "shift"], "Left", lazy.layout.decrease_ratio()),

    # Move windows up or down in current stack Key([mod, "control"], "k", lazy.layout.shuffle_down()),
    Key([mod, "control"], "j", lazy.layout.shuffle_up()),

    # Switch window focus to other pane(s) of stack
    Key([mod], "space", lazy.layout.next()),

    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate()),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split()),
    Key([mod], "Return", lazy.spawn("terminator")),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod], "w", lazy.window.kill()),

    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.shutdown()),
    Key([mod], "r", lazy.spawncmd()),
    Key([mod], "d", lazy.spawn('rofi -show run')),
]

groups = [
    Group('1: Terminals ', matches=[Match(wm_class=["Terminator", "URxvt","XTerm"])]),
    Group('2: Browser ', matches=[Match(wm_class=["Firefox"])]),
    Group('3: Files ', matches=[Match(wm_class=["Pcmanfm"])]),
    Group('4: Music ', matches=[Match(wm_class=["Rhythmbox"])])
]

# groups = [Group(i) for i in '1234']

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name[0], lazy.group[i.name].toscreen()),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key([mod, "shift"], i.name[0], lazy.window.togroup(i.name)),
        Key([mod], "r", lazy.spawncmd()),
        Key([mod], "r", lazy.spawncmd()),
        Key([mod], "r", lazy.spawncmd()),
    ])

#   Screens Config
# ------------------
flat_theme = {"bg_dark": ["#606060", "#000000"],
              "bg_light": ["#707070", "#303030"],
              "font_color": ["#ffffff", "#cacaca"],

              # groupbox
              "gb_selected": ["#7BA1BA", "#215578"],
              "gb_urgent": ["#ff0000", "#820202"]
              }

gloss_theme = {"bg_dark": ["#505050",
                           "#303030",
                           "#202020",
                           "#101010",
                           "#202020",
                           "#303030",
                           "#505050"],
               "bg_light": ["#707070",
                            "#505050",
                            "#505050",
                            "#505050",
                            "#505050",
                            "#707070"],
               "font_color": ["#ffffff", "#ffffff", "#cacaca", "#707070"],

               # groupbox
               "gb_selected": ["#707070",
                               "#505050",
                               "#404040",
                               "#303030",
                               "#404040",
                               "#505050",
                               "#707070"],
               "gb_urgent": ["#ff0000",
                             "#820202",
                             "#820202",
                             "#820202",
                             "#820202",
                             "#ff0000"
                             ]
               }
theme = gloss_theme

# Layout Theme
layout_theme = {
    "border_width" : 2,
    "margin" : 3,
    "border_focus" : "#005f0c",
    "border_normal" : "#555555"
}

layouts = [
    layout.Max(**layout_theme),
    layout.Stack(num_stacks=2, **layout_theme),
    layout.Matrix(3, **layout_theme),
    layout.MonadTall(**layout_theme),
#   layout.Floating(border_width=2, **layout_theme)
]

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

# Widgets Theme
# widget_defaults = dict(background=theme["bg_light"],
                       # opacity=0.9,
                       # border_color="#6f6f6f",
                       # fontshadow="#000000",
                       # foreground=theme["font_color"],
                       # fontsize=14,
                       # font="Anonymous Pro",
                       # )

widget_defaults = dict(
    font='sans',
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()


def init_colors():
    return {
        "orange": "#FB7941",
        "red" : "#E6117A",
        "purple" : "#630FA1",
        "blue" : "#2679B2",
        "cyan" : "#13A9A7"
    }

power_colors = init_colors()

screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.GroupBox(fontsize=14),
                widget.Prompt(fontsize=14),
                widget.WindowName(fontsize=10),

                widget.Image(scale=True, filename='~/.config/qtile/ar-cyan.png',background='#630FA1'),
                widget.CurrentLayout(fontsize=14, background=power_colors["cyan"]),
                widget.Image(scale=True, filename='~/.config/qtile/4-ar-blue.png',background='#630FA1'),
                widget.Systray(background=power_colors["blue"]),
                #widget.Sep(padding=10),
                widget.Image(scale=True, filename='~/.config/qtile/3-ar-purple.png',background='#630FA1'),
                widget.CheckUpdates(distro='Arch', display_format=': {updates}', colour_have_updates='#C53B3B', colour_no_updates='#4AA04A', fontsize=14, background=power_colors["purple"]),
                #widget.Sep(padding=10),
                widget.Image(scale=True, filename='~/.config/qtile/2-ar-red.png',background=power_colors["purple"]),
                widget.TextBox(text="Vol:", fontsize=15, background=power_colors["red"]),
                widget.Volume(fontsize=14,background=power_colors["red"]),
                #widget.Sep(padding=10),
                widget.Image(scale=True, filename='~/.config/qtile/1-ar-orange.png',background=power_colors["red"]),
                widget.Clock(format='%d/%m/%Y %a %I:%M %p', fontsize=14, background=power_colors["orange"]),
            ],
            24,
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

#   Screens Config
# ------------------
flat_theme = {"bg_dark": ["#606060", "#000000"],
              "bg_light": ["#707070", "#303030"],
              "font_color": ["#ffffff", "#cacaca"],

              # groupbox
              "gb_selected": ["#7BA1BA", "#215578"],
              "gb_urgent": ["#ff0000", "#820202"]
              }

gloss_theme = {"bg_dark": ["#505050",
                           "#303030",
                           "#202020",
                           "#101010",
                           "#202020",
                           "#303030",
                           "#505050"],
               "bg_light": ["#707070",
                            "#505050",
                            "#505050",
                            "#505050",
                            "#505050",
                            "#707070"],
               "font_color": ["#ffffff", "#ffffff", "#cacaca", "#707070"],

               # groupbox
               "gb_selected": ["#707070",
                               "#505050",
                               "#404040",
                               "#303030",
                               "#404040",
                               "#505050",
                               "#707070"],
               "gb_urgent": ["#ff0000",
                             "#820202",
                             "#820202",
                             "#820202",
                             "#820202",
                             "#ff0000"
                             ]
               }
theme = gloss_theme

dgroups_key_beinder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

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
