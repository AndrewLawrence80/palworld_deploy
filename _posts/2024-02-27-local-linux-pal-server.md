---
layout: post
title:  "幻兽帕鲁本地Linux服务器"
date:   2024-02-27 12:40:00 +0800
---

本篇介绍基于Virtualbox虚拟机运行专有服务器，用于在云服务器到期时将存档转移到本地接着玩

**本篇创建和导入虚拟机二选一**

建议虚拟机配置为4核、8-16G

## 开启CPU虚拟化支持

确保电脑的硬件设置开启了CPU虚拟化支持，查看方法可以参考[bluestacks-如何开启虚拟化](https://support.bluestacks.com/hc/en-us/articles/360058102252-How-to-enable-Virtualization-VT-on-Windows-10-for-BlueStacks-5)和[知乎-查看和启用虚拟化](https://www.zhihu.com/question/55300843/answer/3254312561)

## 下载安装Virtuabox

1. 进入[Virtualbox下载界面](https://www.virtualbox.org/wiki/Downloads)，下载对应操作系统的Virtuabox
   ![vbox_download]({{site.baseurl}}/assets/2024-02-27-local-linux-pal-server/virtuabox_download.png)
   - 安装时如果提示需要VC2019 Redistributable，需要先进入[微软下载页面](https://learn.microsoft.com/zh-cn/cpp/windows/latest-supported-vc-redist?view=msvc-170#visual-studio-2015-2017-2019-and-2022)下载安装VC Redistributable
    ![vc_redist]({{site.baseurl}}/assets/2024-02-27-local-linux-pal-server/vc_redist.png)
2. 按照默认设置安装即可

## 创建虚拟机

1. 如果需要自己创建虚拟机，可以参考[linuxsimply-在vbox创建Debian虚拟机](https://linuxsimply.com/linux-basics/os-installation/virtual-machine/ ebian-on-virtualbox/)，转[一键脚本]({{site.posts.2024-02-21-linux-palserver}})
2. 参考[存档备份与导入]({{site.posts.2024-02-21-pal-backup}})，导入游戏存档
3. 设置virtualbox host-only网络，在virtualbox主界面选择`管理`-`工具`-`网络管理器`-`仅主机(Host-Only)网络`-`VirtualBox Host-Only Ethernet Adapter`-`DHCP服务器`，设置`最大地址`为`192.168.56.200`，将`192.168.56.201`-`192.168.56.254`预留为静态地址
    ![virtualbox_network]({{site.baseurl}}/assets/2024-02-27-local-linux-pal-server/virtualbox_network.png)
4. 为虚拟机分配Host-Only网络，在虚拟机设置页面选择`网络`-`网卡2`，添加`仅主机(Host-Only)`网络并启用
    ![vm_network]({{site.baseurl}}/assets/2024-02-27-local-linux-pal-server/vm_network.png)
5. 设置虚拟机网络，编辑`/etc/network/interfaces`，为Host-Only网络对应的网络接口赋予固定IP`192.168.56.201`
    ![vm_interfaces]({{site.baseurl}}/assets/2024-02-27-local-linux-pal-server/vm_interfaces.png)
6. 重启虚拟机，在游戏界面选择`加入多人游戏(专有服务器)`，IP地址为`192.168.56.201`，密码为游戏存档对应的密码

## 导入虚拟机

1. 下载并解压VBox服务器镜像，建议解压到处于SSD的分区
2. 双击.vbox文件导入虚拟机，以下步骤3,4可以选择性跳过
3. 设置virtualbox host-only网络，在virtualbox主界面选择`管理`-`工具`-`网络管理器`-`仅主机(Host-Only)网络`-`VirtualBox Host-Only Ethernet Adapter`-`DHCP服务器`，设置`最大地址`为`192.168.56.200`，将`192.168.56.201`-`192.168.56.254`预留为静态地址
    ![virtualbox_network]({{site.baseurl}}/assets/2024-02-27-local-linux-pal-server/virtualbox_network.png)
4. 为虚拟机分配Host-Only网络，在虚拟机设置页面选择`网络`-`网卡2`，添加`仅主机(Host-Only)`网络并启用
    ![vm_network]({{site.baseurl}}/assets/2024-02-27-local-linux-pal-server/vm_network.png)
5. 启动游戏，在游戏界面选择`加入多人游戏(专有服务器)`，IP地址为`192.168.56.201`，密码为游戏存档对应的密码