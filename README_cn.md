<p align="center">
<img alt="Frameworks a lot - he's one!" src="logo.png">
</p>


[![Latest Stable Version](https://poser.pugx.org/maxlab/stacker/v/stable)](https://packagist.org/packages/maxlab/stacker)
[![Build Status](https://travis-ci.org/Maxlab/stacker.svg?branch=master)](https://travis-ci.org/Maxlab/stacker)
[![License](https://poser.pugx.org/maxlab/stacker/license)](https://packagist.org/packages/maxlab/stacker)
[![Latest Unstable Version](https://poser.pugx.org/maxlab/stacker/v/unstable)](https://packagist.org/packages/maxlab/stacker)

# Stacker

- [English](https://github.com/Maxlab/stacker)
- [简体中文](https://github.com/Maxlab/stacker/blob/master/README_cn.md)

#### Stacker 是什么?
Stacker 是一个 Docker 项目，几乎包含了 Web 开发的所有环境 Node.js、PHP、MySQL、PostgreSQL、Redis、Elasticsearch等等。

#### Stacker 特色功能？

- **邮件外发调试**

  将你的应用的发信服务器设置为 `mailcatcher` ，端口设置为 `1025` 就可以在 http://mail.dev 中查看应用发出的邮件啦

- **使用PHPStorm调试PHP应用**

  - 查看 [视频](https://youtu.be/RdmcGAAQGfI) 教程 (俄语)

  1. Go to Settings -> Languages & Frameworks -> PHP
  2. Click the ... behind your interperter

- **绿色便携的 PHP & Node 终端**

  宿主机无需安装 PHP 及 Node.js 即可使用 `stacker console` 在你的项目中执行 `php hello.php` 和 `ndoe hello.js` 。

## 安装

安装之前请先安装 [Docker](https://docker.com) 。

#### 获取 stacker ： 
```sh 
$ composer create-project maxlab/stacker 
# 或者
$ git clone git@github.com:Maxlab/stacker.git
```

#### 在 stacker 目录下运行： 
```sh 
# make ./workspace folder and make a symbolic link to your folder with all your projects 
$ mkdir workspace && ln -s /your_path/to_all_your_own_projects ./workspace
# copy .env.dist to .env and change it
$ cp .env.dist .env
$ docker-compose build && docker-compose up -d && docker-compose ps
$ mv ./test ./workspace
```
#### 设置DNS服务器

```sh
- Linux
  /etc/resolv.conf
- Mac
  在 系统偏好设置 中
- Windows
  在 网络适配器设置 --> TCP/IP协议 中
```

将你的DNS服务器设置为`127.0.0.1`，为了防止dnsmasq出现故障，你必须设置第二dns服务器，比如114.114.114.114或者其他。

- 在浏览器中打开 http://test.php.dev/
- [示例视频](https://youtu.be/42BemUfK5-4)

#### SSH
复制你的SSH秘钥进 stacker 工作目录
```sh
$ cp -R ~/.ssh ~/www/docker/stacker/workspace 
```
#### 启动项目
- 将你的项目放进工作目录 `./workspace/<customer>/<projectname>`（无需重启 stacker ）
- 在浏览器中打开 http://customer.project.dev/ （如果你没有安装`dnsmasq`的话你必须在`hosts`文件中添加这个域名）

## 常见问题

#### 怎么设置数据库密码？
修改`.env`文件里面数据库密码的参数。

#### 如何在项目中连接容器？

- 数据库

  ```yaml
    # Example for mysql
    parameters:
      database_host: mysql #主机就填mysql
      database_port: 3306
      database_name: sf
      database_user: root
      database_password: root

    # Example for pgsql
    parameters:
      database_host: pgsql #主机就填pgsql
      database_port: 5433
      database_name: sf
      database_user: postgres
      database_password: postgres
    
    # Example for redis
    parameters:
      database_host: redis #主机就填redis
      database_port: 6379
  ```

#### I have a lot of the Symfony project, is it possible to make a symbolic link to them? 
- Yes! It's much faster and easier, plus no need to move folders from the usual places.
- In the directory with your projects, create a folder and copy all the projects from the Symfony code. 
  Now, make a link to your directory project in the directory with the Stacker, 
  remove a directory `./workspace` and rename your link to workspace - that's all! 
  Now all your Symfony projects is available from the browser.

#### 怎么使用终端？
将 stacker 添加到系统变量中，
```sh
# for bash
$ echo 'export PATH=/your_path/to_stacker_folder/bin:$PATH' >> ~/.bashrc && source ~/.bashrc 
# for ~/.zshrc
$ echo 'export PATH=/your_path/to_stacker_folder/bin:$PATH' >> ~/.zshrc && source ~/.zshrc
# then restart console and run
$ stacker console
```
然后
```sh 
$stacker console
```


#### Symfony completion
```sh
$ stacker console
$ cd to_symfony_folder
$ sf [tab*2] # for sf3 completion OR sf2 for sf2 completion
```

#### Laravel5 completion
```sh
$ stacker console
$ cd to_symfony_folder
$ la5 [tab*2]
```

## Commands
```sh
$ stacker usage # for list available commands
$ stacker console # for enter to console
$ stacker logs <cont_name> -f # for logs stream container
$ stacker build && stacker down && stacker up && stacker ps # for full rebuild
```

## Support project
简体中文版由 @[奶爸](http://github.com/naiwa) 翻译

You can support the project in several ways:

1. Becoming a sponsor - If you are interested in becoming a sponsor, please visit the Stacker [Patreon page](http://patreon.com/maxlab)
2. Posting review - You can support the project by posting reviews in their social networks. Send a link to the review and we'll post it here!
3. Buy a beer - [![Gratipay User](https://img.shields.io/gratipay/user/maxlab.svg)](https://gratipay.com/~maxlab) [![Bountysource](https://img.shields.io/bountysource/team/maxlabstacker/activity.svg)](https://www.bountysource.com/teams/maxlabstacker) [![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=Q477VJVB9STGS)
