
import json

from pymouse import PyMouse
import Xlib
import Xlib.X
import Xlib.display

from dra_utils import ByPassOriginWebSocketHandler
from dra_utils.log import server_log

def filter_event_to_local(event):
    '''Recalculate cursor position'''
    # localX / localWidth = remoteOffsetX / remoteVideoWidth
    event['localX'] = int(event['x'] * screen_width / event['w'])
    event['localY'] = int(event['y'] * screen_height / event['h'])
    return event

def get_screen_resolution():
    '''Get current resolution of default screen'''
    resolution = Xlib.display.Display().screen().root.get_geometry()
    return (resolution.width, resolution.height)

mouse = PyMouse()
screen_width, screen_height = get_screen_resolution()

def move(event):
    mouse.move(event['localX'], event['localY'])

def button_press(event):
    mouse.press(event['localX'], event['localY'], button=event['button'])

def button_release(event):
    mouse.release(event['localX'], event['localY'], button=event['button'])

# Mouse event handlers
handlers = {
    Xlib.X.MotionNotify: move,
    Xlib.X.ButtonPress: button_press,
    Xlib.X.ButtonRelease: button_release,
}

def handle(msg):
    '''Handle mouse event'''
    try:
        event = json.loads(msg)
    except ValueError as e:
        server_log.warn('[mouse] failed to parse mouse event: %s' % msg)
        return

    # event filter
    event = filter_event_to_local(event)

    try:
        handler = handlers[event['type']]
        handler(event)
    except (KeyError, ValueError) as e:
        server_log.warn('[mouse] unknown mouse event: %s' % event)


class MouseWebSocket(ByPassOriginWebSocketHandler):
    '''mouse message handler'''

    def on_message(self, msg):
        handle(msg)

    def on_close(self):
        # TODO: release any mouse event
        pass
