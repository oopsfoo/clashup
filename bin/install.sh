#!/bin/bash
now=$(date +"%Y-%m-%d_%H_%M_%S")
workpath="/tmp/clashup_$now/"
mkdir -p $workpath
pushd $workpath
curl -s https://api.github.com/repos/Dreamacro/clash/releases\
	| grep 'browser_download_url.*linux-amd64'\
	| tail -n1\
	| awk '{print $2}'\
	| tr -d \"\
	| wget -qi -
tarball=$(ls)
echo $tarball
gunzip -c $tarball > clash
chmod +x clash
mv ./clash /opt/clash/bin
rm -fr $workpath
#TODO get configuration from remote
sudo apt install -y supervisor
sudo ln -s /opt/clash/conf/supervisor.conf /etc/supervisor/conf.d/clash.conf
sudo service supervisor restart
sudo supervisorctl status
