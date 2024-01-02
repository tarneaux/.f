from libqtile.config import Screen
from bar import my_bar, widget_defaults, extension_defaults

screens = [
    Screen(
        top=my_bar,
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,
        wallpaper="~/.config/awesome/theme/walls/foggy-forest-3.jpg",
        wallpaper_mode="fill",
    ),
]
