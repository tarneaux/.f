import colors
from libqtile import layout

layout_settings = {
    "border_focus": colors.bright_orange,
    "border_normal": colors.gray,
    "border_width": 2,
    "margin": 25,
}

layouts = [
    layout.MonadTall(
        **layout_settings,
    ),
    layout.Max(
        **layout_settings,
    ),
]
