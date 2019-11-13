#!/bin/bash

sudo apt install -y supervisor

now_ts=$(date +"%Y-%m-%d_%H_%M_%S")
work_path="/tmp/clashup_$now_ts/"
curr_path=$(dirname "$(readlink -f "$0")")
root_path=$(dirname $curr_path)

mkdir -p $work_path
pushd $work_path
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
mv ./clash $curr_path
popd
rm -fr $work_path

mkdir $root_path/log

sudo ln -sf $root_path /opt/clashup

#TODO get configuration from remote

sed -i "s/oopsfoo/$USER/g" ../conf/supervisor.conf
sudo ln -sf "$(readlink -f ../conf/supervisor.conf)" /etc/supervisor/conf.d/clashup.conf
sudo service supervisor restart
sudo supervisorctl status

