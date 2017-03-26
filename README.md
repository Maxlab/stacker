<p align="center">
<img alt="Frameworks a lot - he's one!" src="logo.png">
</p>


[![Latest Stable Version](https://poser.pugx.org/maxlab/stacker/v/stable)](https://packagist.org/packages/maxlab/stacker)
[![Build Status](https://travis-ci.org/Maxlab/stacker.svg?branch=master)](https://travis-ci.org/Maxlab/stacker)
[![License](https://poser.pugx.org/maxlab/stacker/license)](https://packagist.org/packages/maxlab/stacker)
[![Latest Unstable Version](https://poser.pugx.org/maxlab/stacker/v/unstable)](https://packagist.org/packages/maxlab/stacker)

## Introduction

#### Why stacker?
Stacker - This is a local environment for web development with everything you need. What is its benefit?
1. You do not need to manually configure the web server and add to the hosts, just cloned it and immediately launched it in the browser. It looks so [demo](https://youtu.be/42BemUfK5-4)
2. Inside, there is already everything that is needed in 90% of all cases. And if not, we will add it for you)
3. For you, there is a super zsh console with autocomplete and everything you need. Video with [presentation](https://youtu.be/N7HpPoNcaA4?list=PLD8VGB8i9TYha8YOd-deV6bX5hZco0ZGy) 
4. There is an autocompletion for Symfony and Laravel commands out of the box. For example, la5 and a double tab, will output a list of commands for which you can "walk" with arrows to select them
5. It is faster analogs, the same homestead is just a turtle compared to it
6. There is a [video course](https://www.youtube.com/playlist?list=PLD8VGB8i9TYha8YOd-deV6bX5hZco0ZGy)
7. Friendly author, in case there are questions or suggestions
8. Based on Docker. Wherever you can install Docker, you can install and Stacker
9. It is very simple to expand. The process of adding your own images with a couple of lines in docker-compose.yml
10. Just try it!

#### General goals
- Frameworks a lot - he's one!
- Everything is easy, nothing to migrate
- Quickly start of developing locally
- No overhead on settings! Сopied project and run
- Zoo under a Docker, let the host mashine remains clean!


#### Video demos (RU)
- [Presentation](https://youtu.be/qVqzYMczuwM)
- [PhpStorm + Xdebug + Stacker = profit!](https://youtu.be/RYnRamdZJ-Q)
- [Console, Composer, Gulp, Npm, Gem, Bower](https://youtu.be/WBFMs35ucfk)
- [Run Symfony, Laravel and native PHP scripts](https://youtu.be/TONMezpUqkc)

## Requirements
- Install [Docker](https://docs.docker.com/)
- Install [Docker Compose](https://docs.docker.com/compose/install/) > 1.8.0

## Installation

#### Get a stacker: 
```sh 
$ composer create-project maxlab/stacker 
# OR
$ git clone git@github.com:Maxlab/stacker.git
```

#### Run in Stacker directory 
```sh 
# make ./workspace folder and make a symbolic link to your folder with all your projects 
$ mkdir workspace && ln -s /your_path/to_all_your_own_projects ./workspace
$ docker-compose build && docker-compose up -d && docker-compose ps
$ \*.dev > 127.0.0.1 # if you use boot2docker, use that ip
$ sudo apt-get update && sudo apt-get install dnsmasq
$ mv ./test ./workspace
$ service docker restart
```
- Add a file `/etc/dnsmasq.d/dev.conf` with `address=/.dev/127.0.0.1`
- Edit `/etc/hosts` file if you want to use a domain name:
  - add `127.0.0.1 test.project.dev` to your hosts file `/etc/hosts`
  - add `127.0.0.1 mail.dev` to your hosts file `/etc/hosts`  
- Then open http://test.php.dev/ in your browser
- [Examples](https://youtu.be/42BemUfK5-4)

#### For SSH
Copy your ssh keys in the folder workspace
```sh
$ cp -R ~/.ssh ~/www/docker/stacker/workspace 
```
#### For pure PHP
- Add your project in workspace folder `./workspace/<customer>/<projectname>` (no need to restart, this will work out of the box)
- Open http://customer.project.dev/ in your browser (if you do not have dnsmasq, you have to add your hosts file manually)

#### For Symfony2
- Add your Sf2 project in workspace folder `./workspace/<customer>/<projectname>` (no need to restart, this will work out of the box)
- Open http://customer.project.dev/ in your browser (if you do not have dnsmasq, you have to add your hosts file manually)

## On the ship
- mailcatcher   -> schickling/mailcatcher:latest (all outgoing mail is sent to http://mail.dev/)
- nginx         -> nginx:1.10.1
- elasticsearch -> elasticsearch:5
- mysql         -> mysql:5.7
- pgsql         -> postgres:9.6   
- php7xdebug    -> php:7.1 + xdebug
- php5apache    -> php:5apache for legacy
- php7console   -> stacker console
- redis         -> redis:3.0

## Console
- *ZSH* + [oh-my-zsh](http://ohmyz.sh/)
- For frontend: nodejs, gem, npm, bower, gulp, uglify-js, uglifycss 
- For backend: composer, php, phpunit, symfony, symfony-autocomplete, Yii2 autocomplete

## FAQ

#### Which settings in the configs for my projects?
- Database
    - You can access the database in your app config use `db` for mysql and `pgsql` for postgresql
        (files will be saved in the mysql directory so it will be saved after destroying or recreating the containers)
    ```yaml
      # Example for mysql
      parameters:
        database_host: mysql
        database_port: 3306
        database_name: sf
        database_user: root
        database_password: root
    
      # Example for pgsql
      parameters:
        database_host: pgsql
        database_port: 5433
        database_name: sf
        database_user: postgres
        database_password: postgres
      
      # Example for redis
      parameters:
        database_host: redis
        database_port: 6379
    ```

#### What external ports are listening images?
- It's easy. For convenience, the external ports of the databases are offset by plus one. 
    For example, MySQL listens to port 3306 + 1 = 3307 and so on...
- Check the file [docker-compose.yml](/docker-compose.yml) for more 

#### How to Configure local wildcard DNS server (for linux)
- Install Dnsmasq:
```sh
$ sudo apt-get install dnsmasq
```
- Since Ubuntu's Network Manager uses Dnsmasq, and since that messes things up a little for us, open up `/etc/NetworkManager/NetworkManager.conf` and comment out (#) the line that:
```
# dns=dnsmasq
```
Restart NetworkManager afterwards: 
```sh
$ sudo restart network-manager
```

- Make sure Dnsmasq listens to local DNS queries by editing `/etc/dnsmasq.conf`, and adding the line `listen-address=127.0.0.1`
- Create a new file in `/etc/dnsmasq.d` (eg. `/etc/dnsmasq.d/dev.conf`), and add the line `address=/.dev/127.0.0.1` to have dnsmasq resolve requests for *.dev domains
- Restart Dnsmasq:
```sh
$ sudo /etc/init.d/dnsmasq restart
```

#### Xdebug + PhpStorm configuration 
- Watch [this video](https://youtu.be/RdmcGAAQGfI) (in Russian)

1. Go to Settings -> Languages & Frameworks -> PHP
2. Click the ... behind your interperter

#### I have a lot of the Symfony project, is it possible to make a symbolic link to them? 
- Yes! It's much faster and easier, plus no need to move folders from the usual places.
- In the directory with your projects, create a folder and copy all the projects from the Symfony code. 
Now, make a link to your directory project in the directory with the Stacker, 
remove a directory `./workspace` and rename your link to workspace - that's all! 
Now all your Symfony projects is available from the browser.

#### How to contact the any instances Staker in console?
You can do so:
```sh 
$ /your_path/to_stacker_folder/bin/stacker console
```
But, it will be much better:
```sh
# for bash
$ echo 'export PATH=/your_path/to_stacker_folder/bin:$PATH' >> ~/.bashrc && source ~/.bashrc 
# for ~/.zshrc
$ echo 'export PATH=/your_path/to_stacker_folder/bin:$PATH' >> ~/.zshrc && source ~/.zshrc
# then restart console and run
$ stacker console
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
You can support the project in several ways:
1. Becoming a sponsor - If you are interested in becoming a sponsor, please visit the Stacker [Patreon page](http://patreon.com/maxlab)
2. Posting review - You can support the project by posting reviews in their social networks. Send a link to the review and we'll post it here!
3. Buy a beer - [![Gratipay User](https://img.shields.io/gratipay/user/maxlab.svg)](https://gratipay.com/~maxlab) [![Bountysource](https://img.shields.io/bountysource/team/maxlabstacker/activity.svg)](https://www.bountysource.com/teams/maxlabstacker) [![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=Q477VJVB9STGS)
