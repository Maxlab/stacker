
Stacker - Symfony docker starter kit for development
===

Video presentation - https://youtu.be/owE3Et6PaQM

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


Installation
---

- Install [docker](https://docs.docker.com/)
- Install docker [compose](https://docs.docker.com/compose/install/) >1.3.1
- Clone this project 
  `git clone git@github.com:Maxlab/docker-compose-development.git development`


Before
---

Tested under Linux. For Windows/Mac, take a look at the docker beta(heard that good performances are met)
Stop all other local Webservers running on port 80/443.

Set-up your database credentials in the conf directory (OPTIONAL)

- conf/mysql
- conf/pgsql

Start
---

- Run `./bin/dev up` from the development directory
- \*.dev > 127.0.0.1 (if you use boot2docker, use that ip)
    - sudo apt-get update && sudo apt-get install dnsmasq
      add a file `/etc/dnsmasq.d/dev.conf` with `address=/.dev/127.0.0.1`
    - hosts
        - add `127.0.0.1 test.project.dev` to your hosts file `/etc/hosts`
        - add `127.0.0.1 mail.dev` to your hosts file `/etc/hosts`
- add your project in workspace `customer/project/htdocs` (no need to restart, this will work out of the box)
- open http://customer.project.dev/ in your browser (if you do not have dnsmasq, you have to add your hosts file manually).
- all outgoing mail is sent to http://mail.dev/


Database
---

Set the desired root password in the conf/mysql section.
To manage database run `./bin/dev myroot`

You can access the database in your app use `db` as hostname.

Files will be saved in the mysql directory so it will be saved after destroying or recreating the containers.


Redis
---

To use redis, use `redis` as hostname in the config of your app.


Console
---

If you want run a console to run php commands.

- `./bin/dev console` - PHP7
- `./bin/dev php` - PHP7

Cron
---

If you use cronjobs in your app, you can add them on your host machine.
`docker ps | grep development_phpfpm && docker exec development_phpfpm_1 su app [YOURCOMMANDHERE]`

For instance, if you must run a Magento cronjob.
`docker ps | grep development_phpfpm && docker exec development_phpfpm_1 su app magento/project/htdocs/cron.sh`

You can add these to your local cron.


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





