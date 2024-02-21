---
layout: post
title:  "幻兽帕鲁专有服务器搭建(Debian)"
date:   2024-02-21 13:39:00 +0800
---

## 一键安装脚本

有Debian使用经验的用户可以在root下将以下内容保存为install.sh, 然后运行`bash install.sh`

``` bash
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
```

## 基于云服务器

### 使用幻兽帕鲁应用镜像

- 优势
  - 最简单，一键部署方便快捷
  - 自带程序控制面板方便调整游戏参数
- 不足
  - 使用不够自由
- 如何部署
  - 访问[腾讯云游戏服务器购买页面](https://cloud.tencent.com/act/pro/lhds)
  - 选择4核16G的云服务器
  - 选择离你最近的地域
  - 镜像Linux和Windows均可

### 使用操作系统镜像

- 优势
  - 使用较为自由
- 不足
  - 需要一定的Linux使用经验
- 如何部署
  - 访问[腾讯云游戏服务器购买页面](https://cloud.tencent.com/act/pro/lhds)
  - 选择4核16G的云服务器
  - 选择离你最近的地域
  - 镜像Linux和Windows均可
  - 在控制台选择`重装系统`
  - 选择`基于操作系统镜像`---`Debian 12`
  - 登陆控制台，使用`nano`将复制的[一键脚本](#一键安装脚本)存为`install.sh`

    - ```bash
      nano install.sh
      ```

    - 复制[一键脚本](#一键安装脚本)
    - 按下`Ctrl+O`后按`Ctrl+X`
  - 运行`install.sh`

    - ```bash
      sudo bash install.sh
      ```

  - 幻兽帕鲁专有服务器将被安装在`/home/steam/.steam/steam/steamapps/common/PalServer/`目录下
