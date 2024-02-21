#!/bin/bash
cp /etc/apt/sources.list /etc/apt/sources.list.backup
echo "deb https://mirrors.tencent.com/debian/ bookworm main contrib non-free non-free-firmware
deb-src https://mirrors.tencent.com/debian/ bookworm main contrib non-free non-free-firmware
deb https://mirrors.tencent.com/debian-security bookworm-security main contrib non-free non-free-firmware
deb-src https://mirrors.tencent.com/debian-security bookworm-security main contrib non-free non-free-firmware
deb https://mirrors.tencent.com/debian/ bookworm-updates main contrib non-free non-free-firmware
deb-src https://mirrors.tencent.com/debian/ bookworm-updates main contrib non-free non-free-firmware
deb https://mirrors.tencent.com/debian/ bookworm-backports main contrib non-free non-free-firmware
deb-src https://mirrors.tencent.com/debian/ bookworm-backports main contrib non-free non-free-firmware" >/etc/apt/sources.list
dpkg --add-architecture i386
apt update
apt install steamcmd -y
mkdir /home/steam
useradd -d /home/steam -U steam
chown -R steam:steam /home/steam
runuser -l steam -c '/usr/games/steamcmd +login anonymous +app_update 2394010 validate +quit'
runuser -l steam -c 'ln -s /home/steam/.steam/steam/steamcmd/linux32 /home/steam/.steam/sdk32'
runuser -l steam -c 'ln -s /home/steam/.steam/steam/steamcmd/linux64 /home/steam/.steam/sdk64'
runuser -l steam -c 'mkdir -p /home/steam/.steam/steam/steamapps/common/PalServer/Pal/Saved/Config/LinuxServer/'
runuser -l steam -c 'cp /home/steam/.steam/steam/steamapps/common/PalServer/DefaultPalWorldSettings.ini /home/steam/.steam/steam/steamapps/common/PalServer/Pal/Saved/Config/LinuxServer/PalWorldSettings.ini'
echo "[Unit]
Description=Palworld Dedicated Server
Wants=network-online.target
After=network-online.target
[Service]
User=steam
Group=steam
Environment="LD_LIBRARY_PATH=/home/steam/:$LD_LIBRARY_PATH"
Environment="SteamAppId=2394010"
ExecStartPre=/usr/games/steamcmd +login anonymous +app_update 2394010 validate +quit
ExecStart=/home/steam/.steam/steam/steamapps/common/PalServer/PalServer.sh -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS > /dev/null
Restart=always
RuntimeMaxSec=24h
[Install]
WantedBy=multi-user.target" >/etc/systemd/system/palworld.service
systemctl enable palworld.service && systemctl daemon-reload && systemctl start palworld.service
