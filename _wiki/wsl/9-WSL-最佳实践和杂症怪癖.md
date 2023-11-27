---
layout: wiki 
subject_slug: wsl
subject: Windows Subsystem for Linux
title: WSL 最佳实践和杂症怪癖 
---

以下分享一些我在使用 Ubuntu@WSL 过程中遇到的问题和经验。

## 1. 使用 WSL1

WSL1 相比 WSL2 有更好的 `跨 OS 文件系统的性能`。

如果你和我一样，使用 WSL 安装 Ubuntu 做为本地的开发环境，在其中安装了 `MySQL`、`PHP`、`Node.js`、`Nginx` 等服务于你的开发工作（而不是把这些软件安装在 Windows 中），项目的运行、编译基于 Ubuntu。
开发工作使用的 IDE 安装在 Windows 中。

这样你的软件项目即被 Windows 读写，同时也被 Ubuntu 读写。
那么你应该使用 WSL1 以获得更好的 `跨 OS 文件系统的性能`。

更多请参阅 [比较 WSL 1 和 WSL 2](https://learn.microsoft.com/zh-cn/windows/wsl/compare-versions#comparing-wsl-1-and-wsl-2){:target="_blank"}。


## 2. Ubuntu 文件的权限和所有者不能修改的问题

/etc/wsl.conf

```ini
[boot]
systemd=true

[automount]
enabled = true
root = /mnt/
options = "metadata,dmask=022,fmask=133"
mountFsTab = false
```

## 3. Nginx 响应卡死问题

/etc/nginx/nginx.conf

```nginx
http {
        fastcgi_buffer_size 1024k;
        fastcgi_buffers 16 256k;
        fastcgi_busy_buffers_size 2048k;
        fastcgi_temp_file_write_size 4096k;
        fastcgi_buffering off;
}
```
