#!/bin/bash
httpport=$(grep '^[[:blank:]]*port' ../conf/config.yml\
	|grep -v '#[[:blank:]]*port'\
	|tail -n1\
	|awk '{print $2}')
sockport=$(grep socks-port ../conf/config.yml|grep -v '#[[:blank:]]*socks'|tail -n1|awk '{print $2}')
echo $httpport
echo $sockport
gsettings set org.gnome.system.proxy.http host '127.0.0.1'
gsettings set org.gnome.system.proxy.http port $httpport
gsettings set org.gnome.system.proxy.https host '127.0.0.1'
gsettings set org.gnome.system.proxy.https port $httpport
gsettings set org.gnome.system.proxy.socks host '127.0.0.1'
gsettings set org.gnome.system.proxy.socks port $httpport
gsettings set org.gnome.system.proxy mode 'manual'
