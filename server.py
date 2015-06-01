#!/usr/bin/env python3

import sys

#from PyQt5 import QtCore
from PyQt5 import QtGui

from dra_client.service.client_dbus import is_client_dbus_running
from dra_server.server_dbus import is_server_dbus_running
from dra_server.server_dbus import ServerDBus
from dra_utils.log import server_log

def main():
    if is_server_dbus_running():
        server_log.warn('[server] server side is running')
        return
    if is_client_dbus_running():
        server_log.warn('[server] client side is running')
        return
    server_dbus = ServerDBus()
    # FIXME: log service failed to dump log
    server_log.debug('Init server dbus: %s' % server_dbus)

    app = QtGui.QGuiApplication(sys.argv)
    app.exec()

if __name__ == '__main__':
    main()
