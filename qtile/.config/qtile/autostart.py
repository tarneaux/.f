import subprocess
import os
from libqtile import hook

@hook.subscribe.startup
def run_every_startup():
    autostart = os.path.expanduser('~/.config/qtile/autostart.sh')
    log = open(os.path.expanduser('~/.local/share/qtile/autostart.log'), 'w')
    subprocess.Popen(
        [autostart],
        shell=True,
        stdout=log,
        stderr=subprocess.STDOUT,
    )
