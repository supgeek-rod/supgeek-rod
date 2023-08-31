---
layout: post
title: Ubuntu@WSL 入门指南
categories: Ubuntu
tags: WSL Ubuntu Linux
---

Windows Subsystem for Linux，简称WSL。可让开发人员按原样运行 GNU/Linux 环境 - 包括大多数命令行工具、实用工具和应用程序 - 且不会产生传统虚拟机或双启动设置开销。

您可以：

1. 在 Microsoft Store 中选择你偏好的 GNU/Linux 分发版。
2. 运行常用的命令行软件工具（例如 grep、sed、awk）或其他 ELF-64 二进制文件。
3. 运行 Bash 脚本和 GNU/Linux 命令行应用程序，包括：
  - 工具：vim、emacs、tmux
  - 语言：NodeJSJavaScript、Python、Ruby、C/C++、C#、F#、Rust、Go 等
  - 服务：SSHD、MySQL、Apache、lighttpd、MongoDB、PostgreSQL。
4. 使用自己的 GNU/Linux 分发包管理器安装其他软件。
5. 使用类似于 Unix 的命令行 shell 调用 Windows 应用程序。
6. 在 Windows 上调用 GNU/Linux 应用程序。
7. 运行直接集成到 Windows 桌面的 GNU/Linux 图形应用程序
8. 将 GPU 加速用于机器学习、数据科学场景等

更多详情请参阅官方的 [适用于 Linux 的 Windows 子系统文档](https://learn.microsoft.com/zh-cn/windows/wsl/){:target="_blank"}

## 一、安装 Ubuntu
最简便的方法是通过 `Microsoft Store` 来安装 `Ubuntu`。可以帮你省出很多的依赖设置步骤。   
遇到问题参阅官方的 [使用 WSL 在 Windows 上安装 Linux](https://learn.microsoft.com/zh-cn/windows/wsl/install){:target="_blank"} 文档。

如果实在是安装不上，你可以试试 [下载发行版，然后手动安装](https://learn.microsoft.com/zh-cn/windows/wsl/install-manual#downloading-distributions){:target="_blank"}。

## 二、Ubuntu@WSL 的最佳实践和杂症怪癖

以下分享一些我在使用 Ubuntu@WSL 过程中遇到的问题和经验。

### 1. 使用 WSL1

WSL1 相比 WSL2 有更好的 `跨 OS 文件系统的性能`。

如果你和我一样，使用 WSL 安装 Ubuntu 做为本地的开发环境，在其中安装了 `MySQL`、`PHP`、`Node.js`、`Nginx` 等服务于你的开发工作（而不是把这些软件安装在 Windows 中），项目的运行、编译基于 Ubuntu。
开发工作使用的 IDE 安装在 Windows 中。

这样你的软件项目即被 Windows 读写，同时也被 Ubuntu 读写。
那么你应该使用 WSL1 以获得更好的 `跨 OS 文件系统的性能`。

更多请参阅 [比较 WSL 1 和 WSL 2](https://learn.microsoft.com/zh-cn/windows/wsl/compare-versions#comparing-wsl-1-and-wsl-2){:target="_blank"}。


### 2. Ubuntu 文件的权限和所有者不能修改的问题

/etc/wsl.conf

```wsl.conf
[boot]
systemd=true

[automount]
enabled = true
root = /mnt/
options = "metadata,dmask=022,fmask=133"
mountFsTab = false
```

### 3. Nginx 响应卡死问题

/etc/nginx/nginx.conf

```nginx.conf
11  http {
15          fastcgi_buffer_size 1024k;
16          fastcgi_buffers 16 256k;
17          fastcgi_busy_buffers_size 2048k;
18          fastcgi_temp_file_write_size 4096k;
19          fastcgi_buffering off;
xx
xx          // ...
xx  }
```
