# jan/02/1970 00:52:13 by RouterOS 6.46.8
# software id = UE7S-QIEU
#
# model = RBM33G
# serial number = A2FD0E6E8746
/interface bridge
add name=local
/interface wireless security-profiles
set [ find default=yes ] authentication-types=wpa2-psk eap-methods="" mode=\
    dynamic-keys supplicant-identity=MikroTik wpa2-pre-shared-key=\
    Gtxfkm<tlf!@34
add authentication-types=wpa2-psk eap-methods="" mode=dynamic-keys name=ku \
    supplicant-identity=MikroTik wpa2-pre-shared-key=Gtxfkm<tlf!@34
add authentication-types=wpa2-psk eap-methods="" mode=dynamic-keys name=\
    sberauto supplicant-identity=MikroTik wpa2-pre-shared-key=S%AutoTech2020
/interface wireless
set [ find default-name=wlan1 ] country=russia3 disabled=no installation=\
    outdoor security-profile=ku ssid=MIkrotik
/ip pool
add name=dhcp_pool0 ranges=10.0.22.100-10.0.22.254
/ip dhcp-server
add address-pool=dhcp_pool0 disabled=no interface=local lease-time=9h10m \
    name=dhcp1
/interface bridge port
add bridge=local interface=ether2
add bridge=local interface=ether3
/ip neighbor discovery-settings
set discover-interface-list=!dynamic
/interface wireless connect-list
add interface=wlan1 security-profile=sberauto ssid=SberAutoTech
add interface=wlan1 security-profile=ku ssid=Sber_KU
/ip address
add address=10.0.22.1/24 interface=local network=10.0.22.0
/ip dhcp-client
add disabled=no interface=wlan1
/ip dhcp-server network
add address=10.0.22.0/24 dns-server=10.0.22.1 gateway=10.0.22.1
/ip dns
set allow-remote-requests=yes
/ip firewall filter
add action=accept chain=input
add action=accept chain=forward
/ip firewall nat
add action=masquerade chain=srcnat out-interface=wlan1
/system leds
add interface=wlan1 leds="wlan1_signal1-led,wlan1_signal2-led,wlan1_signal3-le\
    d,wlan1_signal4-led,wlan1_signal5-led" type=wireless-signal-strength
add interface=wlan1 leds=wlan1_tx-led type=interface-transmit
add interface=wlan1 leds=wlan1_rx-led type=interface-receive
/ip service
set telnet disabled=yes
set ftp disabled=yes
set ssh disabled=yes
set api disabled=yes
set api-ssl disabled=yes
/system clock
set time-zone-name=Europe/Moscow
/system identity
set name="Svetofor 83 Router"
/user set password=minks2012 [find name=admin]
