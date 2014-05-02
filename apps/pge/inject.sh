#!/bin/sh
set -e
set -x

APP_PATH=/srv/pge

git clone --depth 1 https://github.com/jtgeibel/pge.git $APP_PATH
cd $APP_PATH

git submodule init
git submodule update

# "env" specific (secure for production, defaults for dev)
# * config/configuration.yml
# * config/databases.yml
# * config/initializers/session_store.rb
# * config/newrelic.yml

rm -rf $APP_PATH/.git $APP_PATH/vendor/plugins/community_engine/.git

mkdir -p $APP_PATH/public/plugin_assets $APP_PATH/public/photos
chown nobody:nogroup $APP_PATH/tmp $APP_PATH/public/plugin_assets $APP_PATH/public/photos

export PATH=/opt/rubies/1.8.7-p374/bin:$PATH
bundle install --deployment --without development --path vendor/bundle --binstubs vendor/bundle/bin

cat > /etc/nginx/nginx.conf <<\EOF
# Must turn off daemon mode to get this to run in docker
daemon off;

worker_processes  1;

events {
  worker_connections  1024;
}

http {
  server_names_hash_bucket_size 64;

  set_real_ip_from 172.17.42.1;

  passenger_root /opt/rubies/latest/passenger-root;
  passenger_ruby /opt/rubies/latest/ruby;
  passenger_friendly_error_pages off;

  passenger_max_pool_size 2;
  passenger_max_preloader_idle_time 604800;

  include       mime.types;
  default_type  application/octet-stream;

  sendfile        on;
  keepalive_timeout  65;

  server {
    listen 80 default_server;
    server_name pittsburghgardenexperiment.org;

    passenger_ruby /opt/rubies/1.8.7-p374/bin/ruby;

    root /srv/pge/public;
    passenger_enabled on;

    passenger_min_instances 2;

    location ~* ^/(images|javascripts|stylesheets|photos)/ {
      expires 21d;
      add_header Cache-Control public;
    }
  }

  server {
    listen 80;
    server_name www.pittsburghgardenexperiment.org;
    return 301 https://pittsburghgardenexperiment.org$request_uri;
  }

  passenger_pre_start http://localhost/;
}
EOF
