from libqtile import bar, widget
import colors

import my_widgets

my_bar = bar.Bar(
    [
        widget.GroupBox(
            highlight_method="line",
            # hide_unused=True,
            highlight_color=[colors.orange, colors.orange],
            other_current_screen_border=colors.bright_orange,
            other_screen_border=colors.bright_orange,
            this_current_screen_border=colors.orange,
            this_screen_border=colors.orange,
            disable_drag=True,
        ),
        widget.CurrentLayout(),
        widget.Prompt(),
        # widget.Chord(
        #     chords_colors={
        #         "launch": ("#ff0000", "#ffffff"),
        #     },
        #     name_transform=lambda name: name.upper(),
        # ),
        widget.Spacer(length=bar.STRETCH),
        widget.Clock(format="%a %b %d %I:%M %p"),
        widget.Spacer(length=bar.STRETCH),
        widget.Battery(
            battery=1,
            charge_char="↑",
            discharge_char="↓",
            empty_char="x",
        ),
        my_widgets.UnisonSync(),
    ],
    30,
    # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
    # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
    background=colors.bg + "dd",
)

widget_defaults = dict(
    font="FantasqueSansM Nerd Font",
    fontsize=20,
    padding=5,
)
extension_defaults = widget_defaults.copy()

