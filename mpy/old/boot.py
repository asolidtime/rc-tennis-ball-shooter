# This file is executed on every boot (including wake-boot from deepsleep)
#import esp
#esp.osdebug(None)
import webrepl
webrepl.start()
def wlan_connect(ssid='iWireWiFi-Leonard', password='iWireSteve'):
    import network
    wlan = network.WLAN(network.STA_IF)
    if not wlan.active() or not wlan.isconnected():
        wlan.active(True)
        print('connecting to:', ssid)
        wlan.connect(ssid, password)
        while not wlan.isconnected():
            pass
    print('network config:', wlan.ifconfig())
wlan_connect()
