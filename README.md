<!--
  Title: Stacker - Symfony docker starter kit for development!
  Description: Quickly start of developing locally with Nginx, PHP7, Mysql, Pgsql, Mailcatcher and Redis.
               No e-mail is send externally, everything is catched by mailcatcher.
  Author: maxlab
  Badge genrator: https://poser.pugx.org/
  -->

Stacker - Symfony docker starter kit for development
===
[![Build Status](https://travis-ci.org/Maxlab/stacker.svg?branch=master)](https://travis-ci.org/Maxlab/stacker)
[![License](https://poser.pugx.org/maxlab/stacker/license)](https://packagist.org/packages/maxlab/stacker)
[![Total Downloads](https://poser.pugx.org/maxlab/stacker/downloads)](https://packagist.org/packages/maxlab/stacker)

- 1 video presentation - https://youtu.be/qVqzYMczuwM (RU)
- 2 video phpStorm + xDebug + Stacker = profit! - https://youtu.be/RYnRamdZJ-Q (RU)
- 3 video stacker console, composer, gem, npm and etc. - https://youtu.be/WBFMs35ucfk (RU)

Quickly start of developing locally with Nginx, PHP7, Mysql, Pgsql, Mailcatcher and Redis.
No e-mail is send externally, everything is catched by mailcatcher.


Base images
---

Currently the next images are used. Trying to rely on official images as much as possible.

- mailcatcher -> schickling/mailcatcher:latest
- nginx -> nginx:1.10.1
- mysql -> mysql:5.7
- php7xdebug -> need for interpreter phpstorm and other
- php7  -> need for container, includes gem, npm, bower, gulp, composer 
- redis -> redis:3.0

If you need php5 and apache2 legacy-a2-php5-v.* branch for you!

Installation
---

- Install [docker](https://docs.docker.com/)
- Install docker [compose](https://docs.docker.com/compose/install/) > 1.8.0
- Clone this project 
  `git clone git@github.com:Maxlab/stacker.git development`


Before
---

Tested under Linux. For Windows/Mac, take a look at the docker beta(heard that good performances are met)
Stop all other local Webservers running on port 80/443.

Set-up your database credentials in the conf directory (OPTIONAL)

- conf/mysql
- conf/pgsql

Start
---

- Run in Stacker direcory 
    - $ docker-compose build
    - $ docker-compose up -d
    - $ docker-compose ps
- \*.dev > 127.0.0.1 (if you use boot2docker, use that ip)
    - sudo apt-get update && sudo apt-get install dnsmasq
      add a file `/etc/dnsmasq.d/dev.conf` with `address=/.dev/127.0.0.1`
    - move ./test to ./workspace
    - (if need) hosts
        - add `127.0.0.1 test.project.dev` to your hosts file `/etc/hosts`
        - add `127.0.0.1 mail.dev` to your hosts file `/etc/hosts`
- all outgoing mail is sent to http://mail.dev/

For pure PHP
- add your project in workspace folder `./workspace/<customer>/<projectname>/htdocs` (no need to restart, this will work out of the box)
- open http://customer.project.dev/ in your browser (if you do not have dnsmasq, you have to add your hosts file manually).
For Symfony2
- add your Sf2 project in workspace folder `./workspace/<customer>/<projectname>` (no need to restart, this will work out of the box)
- open http://customer.project.dev/ in your browser (if you do not have dnsmasq, you have to add your hosts file manually).


Database
---

- Set the desired root password in the conf/mysql section.
    To manage database run `./bin/dev myroot`
- You can access the database in your app use `db` as hostname.
- Files will be saved in the mysql directory so it will be saved after destroying or recreating the containers.


Redis
---

To use redis, use `redis` as hostname in the config of your app.


Console
---

If you want run a console to run php commands.

- `./bin/dev console` - PHP7, gem, npm, bower, gulp, composer


Symfony
---

- $ cd to_symfony_folder
- $ bin/console[tab] - for completion


How to
---

- Configure local wildcard DNS server(for linux)
    - Install Dnsmasq: sudo apt-get install dnsmasq
    - Since Ubuntu's NetworkManager uses dnsmasq, and since that messes things up a little for us, open up /etc/NetworkManager/NetworkManager.conf and comment out (#) the line that reads dns=dnsmasq. Restart NetworkManager afterwards: sudo restart network-manager.
    - Make sure Dnsmasq listens to local DNS queries by editing /etc/dnsmasq.conf, and adding the line listen-address=127.0.0.1.
    - Create a new file in /etc/dnsmasq.d (eg. /etc/dnsmasq.d/dev.conf), and add the line address=/.dev/127.0.0.1 to have dnsmasq resolve requests for *.dev domains. Restart Dnsmasq: sudo /etc/init.d/dnsmasq restart.
    
- xDebug + PhpStorm configuration
    Watch this video https://youtu.be/RdmcGAAQGfI
    -dinclude_path=./:/usr/local/lib/php:/root/.composer/vendor/phpunit
    
- I have a lot of the Symphony project, is it possible to make a symbolic link to them? 
    - Yes! It's much faster and easier, plus no need to move folders from the usual places.
    - In the directory with your projects, create a folder and copy all the projects from the Symphony code. 
    Now, make a link to your directory project in the directory with the Stacker, 
    remove a directory ./workspace and rename your link to workspace - that's all! 
    Now all your Symphony projects is available from the browser.

- How to contact the Staker from anywhere in console?
    - $ echo 'alias stacker="/your_path/to_stacker_folder/bin/dev $@"' >> ~/.bashrc
    - $ alias stacker="/your_path_to/stacker_folder/bin/dev $@"
    - $ stacker



