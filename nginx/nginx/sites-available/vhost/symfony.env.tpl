server {
    listen 80;
    server_name *.symfony.dev;

    set $customer "default";
    set $project "default";

    if ( $host ~ "^([^\.]+)\.([^\.]+)\.symfony\.dev$"  ) {
    set $customer "$1";
    set $project "$2";
    }

    set $SYMFONY_ROOT /data/$customer/$project;

    include sites-available/vhost/symfony.content.$SYMFONY_ENV;
}
