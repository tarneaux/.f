from libqtile.config import Key
from libqtile.command import lazy
from libqtile.config import Group
from libqtile.config import Click, Drag

mod = "mod4"
terminal = "alacritty"

home_row_left = "arstd"
home_row_right = "hneio"

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], home_row_right[1], lazy.layout.left(), desc="Move focus to left"),
    Key([mod], home_row_right[2], lazy.layout.up(), desc="Move focus up"),
    Key([mod], home_row_right[3], lazy.layout.down(), desc="Move focus down"),
    Key([mod], home_row_right[4], lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, "shift"],
        home_row_right[1],
        lazy.layout.shuffle_left(),
        desc="Move window to the left",
    ),
    Key(
        [mod, "shift"],
        home_row_right[2],
        lazy.layout.shuffle_up(),
        desc="Move window up",
    ),
    Key(
        [mod, "shift"],
        home_row_right[3],
        lazy.layout.shuffle_down(),
        desc="Move window down",
    ),
    Key(
        [mod, "shift"],
        home_row_right[4],
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key(
        [mod, "control"],
        home_row_right[1],
        lazy.layout.grow_left(),
        desc="Grow window to the left",
    ),
    Key(
        [mod, "control"],
        home_row_right[2],
        lazy.layout.grow_up(),
        desc="Grow window up",
    ),
    Key(
        [mod, "control"],
        home_row_right[3],
        lazy.layout.grow_down(),
        desc="Grow window down",
    ),
    Key(
        [mod, "control"],
        home_row_right[4],
        lazy.layout.grow_right(),
        desc="Grow window to the right",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "comma", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key(
        [mod],
        "c",
        lazy.window.toggle_floating(),
        desc="Toggle floating on the focused window",
    ),
    Key([mod], "q", lazy.reload_config(), desc="Reload the config"),
    Key([mod], "p", lazy.spawn("fuzzel"), desc="Spawn a program using fuzzel"),
]

groups = [Group(i) for i in home_row_left + home_row_right[:1]]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name),
                desc="Move focused window to group {}".format(i.name),
            ),
        ]
    )

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
