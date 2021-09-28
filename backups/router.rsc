# aug/02/2021 19:06:34 by RouterOS 6.48.3
# software id = J35H-DB17
#
# model = RB760iGS
# serial number = A519096902C7
/caps-man channel
add band=2ghz-g/n control-channel-width=20mhz extension-channel=XX frequency=\
    2412 name="CH1 2.4" tx-power=16
add band=5ghz-n/ac control-channel-width=20mhz extension-channel=Ce \
    frequency=5200 name="CH1 5" tx-power=20
add band=2ghz-g/n control-channel-width=20mhz extension-channel=XX frequency=\
    2437 name="CH2 2.4" tx-power=16
add band=2ghz-g/n control-channel-width=20mhz extension-channel=XX frequency=\
    2462 name="CH3 2.4" tx-power=16
add band=5ghz-n/ac control-channel-width=20mhz extension-channel=Ce \
    frequency=5220 name="CH2 5" tx-power=20
add band=5ghz-n/ac control-channel-width=20mhz extension-channel=Ce \
    frequency=5240 name="CH3 5" tx-power=20
/interface bridge
add name=lan
add name=wan
/caps-man datapath
add bridge=lan client-to-client-forwarding=no local-forwarding=yes name=\
    datapath1
/caps-man security
add authentication-types=wpa2-psk encryption=aes-ccm name=security1 \
    passphrase=hello8io
/caps-man configuration
add channel="CH1 2.4" comment=AP1 country=russia3 datapath=datapath1 \
    distance=indoors guard-interval=any hw-protection-mode=rts-cts \
    hw-retries=7 installation=indoor mode=ap name="AP1 2.4" rx-chains=0,1,2,3 \
    security=security1 ssid=hello.io tx-chains=0,1,2,3
add channel="CH1 5" country=russia3 datapath=datapath1 distance=indoors \
    installation=indoor mode=ap name="AP1 5" rx-chains=0,1,2,3 security=\
    security1 ssid="hello.io 5G" tx-chains=0,1,2,3
add channel="CH2 5" country=russia3 datapath=datapath1 distance=indoors \
    installation=indoor mode=ap name="AP2 5" rx-chains=0,1,2,3 security=\
    security1 ssid="hello.io 5G" tx-chains=0,1,2,3
add channel="CH3 5" country=russia3 datapath=datapath1 distance=indoors \
    installation=indoor mode=ap name="AP3 5" rx-chains=0,1,2,3 security=\
    security1 ssid="hello.io 5G" tx-chains=0,1,2,3
add channel="CH2 2.4" comment=AP2 country=russia3 datapath=datapath1 \
    distance=indoors guard-interval=any hw-protection-mode=rts-cts \
    hw-retries=7 installation=indoor mode=ap name="AP2 2.4" rx-chains=0,1,2,3 \
    security=security1 ssid=hello.io tx-chains=0,1,2,3
add channel="CH3 2.4" comment=AP3 country=russia3 datapath=datapath1 \
    distance=indoors guard-interval=any hw-protection-mode=rts-cts \
    hw-retries=7 installation=indoor mode=ap name="AP3 2.4" rx-chains=0,1,2,3 \
    security=security1 ssid=hello.io tx-chains=0,1,2,3
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip hotspot profile
set [ find default=yes ] html-directory=hotspot
/ip pool
add name=dhcp_pool1 ranges=10.0.24.150-10.0.24.254
add name=dhcp_pool2 ranges=192.168.1.150-192.168.1.254
/ip dhcp-server
add address-pool=dhcp_pool2 disabled=no interface=lan lease-time=9h10m name=\
    dhcp1
/queue simple
add max-limit=96M/96M name=queue1 queue=\
    pcq-upload-default/pcq-download-default target=lan
/caps-man manager
set enabled=yes
/caps-man provisioning
add action=create-dynamic-enabled comment=AP1 hw-supported-modes=g,gn \
    master-configuration="AP1 2.4" name-prefix="Hello Park 2.4G"
add action=create-dynamic-enabled hw-supported-modes=an,ac \
    master-configuration="AP1 5" name-prefix="Hello Park 5G"
add action=create-dynamic-enabled comment=AP2 hw-supported-modes=g,gn \
    master-configuration="AP2 2.4" name-prefix="Hello Park 2.4G"
add action=create-dynamic-enabled hw-supported-modes=an,ac \
    master-configuration="AP2 5" name-prefix="Hello Park 5G"
add action=create-dynamic-enabled comment=AP3 hw-supported-modes=g,gn \
    master-configuration="AP3 2.4" name-prefix="Hello Park 2.4G"
add action=create-dynamic-enabled hw-supported-modes=an,ac \
    master-configuration="AP3 5" name-prefix="Hello Park 5G"
/interface bridge port
add bridge=wan interface=ether1
add bridge=lan interface=ether2
add bridge=lan interface=ether3
add bridge=lan interface=ether4
add bridge=lan interface=ether5
/ip address
add address=192.168.1.1/24 interface=lan network=192.168.1.0
/ip dhcp-client
add disabled=no interface=wan
/ip dhcp-server network
add address=10.0.24.0/24 dns-server=10.0.24.1 gateway=10.0.24.1
add address=192.168.1.0/24 dns-server=192.168.1.1 gateway=192.168.1.1
/ip dns
set allow-remote-requests=yes
/ip firewall filter
add action=accept chain=input comment="accept establish & related" \
    connection-state=established,related
add action=accept chain=forward connection-state=established,related
add action=accept chain=forward comment="allow remote req for lan only" \
    dst-port=53 in-interface=!wan protocol=udp
add action=drop chain=forward connection-state=invalid
add action=drop chain=input comment="drop invalid" connection-state=invalid
add action=accept chain=input comment="accept ICMP" protocol=icmp
add action=drop chain=input comment="drop all not from lan" in-interface=!lan
add action=drop chain=forward comment="drop all from WAN to LAN" \
    connection-nat-state=!dstnat connection-state=new in-interface=wan
/ip firewall nat
add action=masquerade chain=srcnat out-interface=wan
/ip service
set telnet disabled=yes
set ftp disabled=yes
set ssh disabled=yes
set api disabled=yes
set api-ssl disabled=yes
/system clock
set time-zone-name=Europe/Moscow
/system identity
set name="Hello Router"
/user set password=hello88io [find name=admin]
