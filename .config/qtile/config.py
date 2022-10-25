#        _   _ _
#   __ _| |_(_) | ___
#  / _` | __| | |/ _ \
# | (_| | |_| | |  __/
#  \__, |\__|_|_|\___|
#     |_|
#


from typing import List  # noqa: F401

from libqtile import bar, layout 
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Rule, Screen
from libqtile.lazy import lazy
from qtile_extras import widget
from qtile_extras.widget.decorations import RectDecoration
from libqtile.utils import guess_terminal
from libqtile.log_utils import logger
from unicodes import right_arrow, left_arrow, lower_left_triangle, left_half_circle, right_half_circle
import os
import subprocess

from libqtile import hook

mod = "mod4"
terminal = "alacritty"
webbrowser = "qutebrowser"
catppuccin = {
    "rosewater" : "#F4DBD6",
	"lamingo" : "#F0C6C6",
	'pink' : "#F5BDE6",
	'mauve' : "#C6A0F6",
	'red' : "#ED8796",
	'maroon' : "#EE99A0",
	'peach' : "#F5A97F",
	'yellow' : "#EED49F",
	'green' : "#A6DA95",
	'teal' : "#8BD5CA",
	'sky' : "#91D7E3",
	'sapphire' : "#7DC4E4",
	'blue' : "#8AADF4",
	'lavender' : "#B7BDF8",

	'text' : "#CAD3F5",
	'subtext1' : "#B8C0E0",
	'subtext0' : "#A5ADCB",
	'overlay2' : "#939AB7",
	'overlay1' : "#8087A2",
	'overlay0' : "#6E738D",
	'surface2' : "#5B6078",
	'surface1' : "#494D64",
	'surface0' : "#363A4F",

	'base' : "#24273A",
	'mantle' : "#1E2030",
	'crust' : "#181926",
}
keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key(
        [mod, "shift"],
        "k",
        lazy.layout.shuffle_up(),
        desc="Move window up",
    ),
    Key([mod, "control"], "j", lazy.layout.shrink(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow(), desc="Grow window up"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "w", lazy.spawn(webbrowser), desc="Launch web browser"),
    # Toggle between different layouts as defined below
    Key([mod], "space", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "n", lazy.layout.reset(), desc="reset size"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_floating(),
        desc="toggle between floating and non floating",
    ),
    Key([mod], "d", lazy.spawn("rofi -show drun")),
    Key([mod], "g", lazy.spawn("i3lock")),
    # Key([mod], "d", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    # Sound
    Key([], "XF86AudioMute", lazy.spawn("amixer -q set Master toggle")),
    Key([], "XF86AudioLowerVolume", lazy.spawn(
        "pactl set-sink-volume @DEFAULT_SINK@ -10%")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn(
        "pactl set-sink-volume @DEFAULT_SINK@ +10%")),
]

# groups = [Group(i) for i in "123456789"]
groups=[
    Group("爵",matches=[Match(wm_class=[])]),
    Group("", matches=[Match(wm_class=["dev"])]),
    Group("ﭮ",matches=[Match(wm_class=["discord"])]),
    Group("",matches=[Match(wm_class=["obsidian"])]),
    Group("",matches=[Match(wm_class=["spotify"])]),
    Group(" ",matches=[Match(wm_class=[])]),
]

for k, group in zip(["1","2","3","4","5","6"], groups):
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                k,
                lazy.group[group.name].toscreen(),
                desc="Switch to group {}".format(group.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                k,
                lazy.window.togroup(group.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(
                    group.name),
            ),
            Key(
                [mod],
                "o",
                lazy.screen.next_group(),
            ),
            Key(
                [mod],
                "i",
                lazy.screen.prev_group(),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

layouts = [
    # layout.Columns(
    #     border_focus="#D08770",
    #     border_normal="#5E81AC",
    #     border_width=3,
    #     margin=8,
    #     border_on_single=True,
    # ),
    layout.MonadTall(
        border_focus=catppuccin["mauve"],
        border_normal=catppuccin["base"],
        border_width=3,
        margin=10,
        border_on_single=True,
    ),
    # layout.Floating(
    #     border_focus="#D08770",
    #     border_normal="#5E81AC",
    #     border_width=3,
    # ),
]
#
nord = {
    "nord0": "#2E3440",  # dark colors
    "nord1": "#3B4252",
    "nord2": "#434C5E",
    "nord3": "#4C566A",
    "nord4": "#D8DEE9",  # light colors
    "nord5": "#E5E9F0",
    "nord6": "#ECEFF4",
    "nord7": "#8FBCBB",  # frost(greens and blues)
    "nord8": "#88C0D0",
    "nord9": "#81A1C1",
    "nord10": "#5E81AC",
    "nord11": "#BF616A",  # aurora(rainbow color)
    "nord12": "#D08770",
    "nord13": "#EBCB8B",
    "nord14": "#A3BE8C",
    "nord15": "#B48EAD",
}


widget_defaults = dict(
    font="JetBrainsMono Nerd Font Medium ",
    fontsize=16,
    padding=5,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    inactive=catppuccin["overlay1"],
                    active=catppuccin["rosewater"],
                    highlight_method="text",
                    highlight_color=catppuccin["rosewater"],
                    padding_x=13,
                    fontsize=23,
                    this_current_screen_border=catppuccin["peach"],
                    background=catppuccin["surface0"]
                ),

                widget.WindowName(max_chars=50, foreground=catppuccin['peach'], fmt="     {}"),

                widget.PulseVolume(
                    fmt="奔{}",
                    mouse_callbacks={
                        "Button1": lazy.spawn("pavucontrol"),
                    },
                    foreground=catppuccin["blue"],
                ),
                widget.TextBox(fmt="|",padding=None,foreground=catppuccin["blue"]),
                widget.KeyboardLayout(
                    configured_keyboards=["us", "ca"], fmt=" {}", 
                    foreground=catppuccin["blue"],

                ),
                widget.Spacer(length=30),
                widget.CPU(
                    foreground=catppuccin["green"],
                    format=" {load_percent}%",
                    mouse_callbacks={
                        "Button1": lazy.spawn("alacritty --class htop -e htop"),
                    },
                ),
                widget.TextBox(fmt="|",padding=None,foreground=catppuccin["green"]),
                widget.Memory(

                    foreground=catppuccin["green"],
                    fmt="{}",
                    mouse_callbacks={
                        "Button1": lazy.spawn("alacritty --class htop -e htop"),
                    },
                ),
                widget.Spacer(length=30),
                widget.Clock(format=" %Y-%m-%d %a %I:%M %p", foreground=catppuccin["rosewater"]),
                widget.Spacer(length=15),
                widget.Spacer(length=15, background=catppuccin["surface0"]),
                widget.Systray(background=catppuccin["surface0"]),
                widget.Spacer(length=30,background=catppuccin["surface0"]),
            ],
            size=40,
            background=catppuccin["base"],
            opacity=1,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="htop"),  # gitk
        Match(title="Volume Control"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(wm_class="update"),  # ssh-askpass
        Match(wm_class="Godot_Engine", title="DEBUG"),  # ssh-askpass
        Match(wm_class="edit-config"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ],
    border_focus=catppuccin["mauve"],
    border_normal=catppuccin["crust"],
    border_width=3,
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"


@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser("~/.config/qtile/autostart.sh")
    subprocess.run([home])
@hook.subscribe.restart
def restart():
    lazy.hide_show_bar("top")
