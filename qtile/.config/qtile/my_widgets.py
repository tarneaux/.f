from libqtile import layout, widget
import subprocess


# A widget displaying whether or not the unison-sync script is running.
# We just pgrep for unison and count the number of lines: there should be
# exactly four.

class UnisonSync(widget.base.ThreadPoolText):
    orientations = widget.base.ORIENTATION_HORIZONTAL
    defaults = [
        ('update_interval', 2, 'Update interval in seconds.'),
        ('foreground', 'ffffff', 'Foreground colour.'),
        ('background', None, 'Background colour.'),
        ('padding', 3, 'Padding between text and edge of widget.'),
        ('font', 'sans', 'Default font.'),
        ('fontsize', None, 'Font size.'),
        ('fontshadow', None, 'Font shadow colour.'),
        ('fontshadowoffset', None, 'Font shadow offset.'),
        ('markup', True, 'Markup for Pango.'),
        ('text_up', ' UP', 'Text to display when up.'),
        ('text_down', ' DOWN', 'Text to display when down.'),
        ('foreground_up', 'ffffff', 'Foreground colour when up.'),
        ('foreground_down', 'ffffff', 'Foreground colour when down.'),
    ]

    def __init__(self, **config):
        widget.base.ThreadPoolText.__init__(self, '', **config)
        self.add_defaults(UnisonSync.defaults)

    def poll(self):
        try:
            ok = len(
                    subprocess.check_output(['pgrep', 'unison']).splitlines()
                ) == 4
        except subprocess.CalledProcessError:
            ok = False
        if ok:
            self.layout.colour = self.foreground_up
            return self.text_up
        else:
            self.layout.colour = self.foreground_down
            return self.text_down
