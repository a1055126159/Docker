#!/bin/bash

# 配置 mysql
config_mysql() {
  bash ./database_config.sh
}

# 启动服务
launch_service() {
  service ssh start
  service rsyslog start
  service nginx start
  service php7.0-fpm start
  cron
}

# clone code from github and config
config_code() { 
  echo 'start clone hifone and config'

  mkdir -p /var/data
  git clone https://github.com/Hifone/Hifone.git /var/data/Hifone
  cd /var/data/Hifone
  cp .env.example .env
  composer install --no-dev -o
  rm database/migrations/2013*
  rm database/migrations/2014*
  php artisan hifone:install
  chmod -R 777 storage
  chmod -R 777 bootstrap/cache
  chmod -R 777 public/uploads
}

launch_service
config_mysql
config_code
