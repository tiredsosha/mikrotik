# jan/02/1970 00:10:10 by RouterOS 6.48.2
# software id = FH5A-4GWA
#
# model = RBcAPGi-5acD2nD
# serial number = BECD0B17BD9E
/interface bridge
add name=bridge1
/interface wireless
# managed by CAPsMAN
# channel: 2412/20-Ce/gn(14dBm), SSID: hello-park.ru, local forwarding
set [ find default-name=wlan1 ] disabled=no ssid=MikroTik
# managed by CAPsMAN
# channel: 5200/20-Ce/ac/P(17dBm), SSID: hello-park.ru, local forwarding
set [ find default-name=wlan2 ] disabled=no ssid=MikroTik
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip hotspot profile
set [ find default=yes ] html-directory=hotspot
/interface bridge port
add bridge=bridge1 interface=all
/interface wireless cap
#
set bridge=bridge1 caps-man-addresses=192.168.1.1 discovery-interfaces=ether1 \
    enabled=yes interfaces=wlan1,wlan2
/ip address
add address=192.168.1.11/24 interface=bridge1 network=192.168.1.0
/system identity
set name="Hello WiFi"
/user set password=hello88io [find name=admin]
