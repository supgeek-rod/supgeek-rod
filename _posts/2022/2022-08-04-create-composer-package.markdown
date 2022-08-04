---
layout: post
title:  Composer Package 开发
categories: PHP
tags: composer
---

前段时间开发了个 Composer Package，今天来记录一下开发 Composer Package 的关键步骤。  

其一是如何在本地创建 Composer Package，核心是 `composer.json` 文件。   
功能开发相关的规范借鉴参照流利的 Package 就好了。

其二是如何引入本地的 Composer Package。


## 1. 在本地创建 Composer Package

### 1). 生成 composer.json
创建 package 目录并进入，并使用 `composer init` 命令初始化

```shell
mkdir MyFirstComposerPackage
cd MyFirstComposerPackage

composer init
```

执行 `composer init` 你将得到一个 `composer.json` 文件，内容如下。   
你也可以直接复制创建此文件，而不使用 `composer init` 来生成。

```json
{
    "name": "supgeek-rod/my-first-composer-package",
    "description": "我的第一个 Composer Package",
    "license": "proprietary",
    "autoload": {
        "psr-4": {
            "SupGeekRod\\MyFirstComposerPackage\\": "src/"
        }
    },
    "authors": [
        {
            "name": "SupeRodv2",
            "email": "supgeek.rod@gmail.com"
        }
    ],
    "require": {}
}
```

你可以自由地修改 `composer.json` 文件内容，值得一提的是 `name` 和 `autoload.psr-4` 的设置。

> `name`: 格式为 `<vendor>/<name>`，命名和文件目录无关。       
> `autoload.psr-4`: 设置 `src` 目录的命名空间（按 PSR-4 规范）。

最后，执行 `composer validate` 以校验 `composer.json` 是否符合要求。

### 2). 进行 Package 开发

我们模拟在 `src` 目录下创建 `Util.php` 文件。   
注意该文件中的 `namespace` 应该与 `composer.json` 文件 `autoload.psr-4` 定义一致。

```php
// /src/Util.php

<?php

namespace SupGeekRod\MyFirstComposerPackage;

class Util
{
    public static getClientIp()
    {
        return getenv('HTTP_CLIENT_IP');
    }
}
```

你可以跳过此步骤，先把你的 Composer Package 安装到你的 PHP 项目中之后，再继续开发。

## 2. 安装你的本地 Composer Package

接下来进入到需要引入 Composer Package 的 PHP 项目中。   
安装该 Composer Package 以便继续开发和测试。

### 1). 添加你的本地 repository 

修改 `/path-to/MyFirstComposerPackage` 为 Composer Package 的实际路径，并执行

```shell
composer config repositories.local path /path-to/MyFirstComposerPackage
```

你会发现在你的 PHP 项目的 `composer.json` 增加了如下内容

```json
{
    "repositories": {
        "local": {
            "type": "path",
            "url": "/path-to/MyFirstComposerPackage"
        }
    }
}
```

### 2). 引入你的 Composer Package

执行以下命令从你的 local repository 安装你的 Composer Package   

```shell
composer require supgeek-rod/my-first-composer-package:@dev
```

> `supgeek-rod/my-first-composer-package` 是你 Composer Package `composer.json` 中定义的 `name`   
> 
> 版本使用 `@dev`

安装成功后你会发现，`vendor/supgeek-rod/my-first-composer-package` 被软链接到你本地的 Composer Package 目录。

你就可以在你的 PHP 项目中使用它。示例如下:

```php
<?php

namespace App\Http\Controllers;

use SupGeekRod\MyFirstComposerPackage\Util;

class IndexController 
{
    public function index()
    {
        // 使用 SupGeekRod\MyFirstComposerPackage\Util 的 getClientIp 静态方法
        $ip = Util::getClientIp();
    }
}
```

## 3. 发布到 packagist.org

Composer Package 开发完成后你可以发布到 packagist.org 中。   
方便自己多项目安装和远程服务器安装的同时，也可供其他人使用，为 PHP 世界添砖加瓦。

此步骤略过，请自行到 https://packagist.org 研究。
