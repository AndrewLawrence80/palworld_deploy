---
layout: post
title:  "幻兽帕鲁存档备份与导入"
date:   2024-02-21 14:30:00 +0800
---

**以下内容基于一键脚本**

## 备份存档

1. 切换用户为steam 
   - `sudo su - steam`
2. 创建备份文件夹
   - `mkdir pal_saved_backup`
3. 定位幻兽帕鲁的安装位置，默认安装位置为`/home/steam/.steam/steam/steamapps/common/PalServer`
4. 备份存档
   - ```/bin/bash -c "cd /home/steam/.steam/steam/steamapps/common/PalServer/Pal/ && tar -czvf /home/steam/pal_saved_backup/Saved_`date +%Y_%m_%d_%H_%M_%S`.tar.gz Saved/"```

**以下操作会覆盖原存档**

## 导入存档

1. 停止游戏服务
    - `systemctl stop palworld.service`
2. 将以上备份好的`Saved_YYYY_mm_dd_HH_MM_SS.tar.gz`游戏存档移到`home/steam/.steam/steam/steamapps/common/PalServer/Pal/`目录下，删除或重命名原来的Saved文件夹
3. 解压游戏存档`tar -zxvf Saved_YYYY_mm_dd_HH_MM_SS.tar.gz`
