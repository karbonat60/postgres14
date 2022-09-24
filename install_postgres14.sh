#!/bin/bash

#install postgresql-14

sudo yum -y install https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
sudo yum -y install epel-release yum-utils
sudo yum-config-manager --enable pgdg14
sudo yum -y install postgresql14-server postgresql14

sudo /usr/pgsql-14/bin/postgresql-14-setup initdb
sudo systemctl enable postgresql-14
sudo systemctl start postgresql-14
sudo su postgres -c "psql -c \"CREATE ROLE vagrant SUPERUSER LOGIN PASSWORD 'vagrant'\" "
sudo su postgres -c "createdb -E UTF8 -T template0 --locale=en_US.utf8 -O vagrant Database"

sudo sed -i  '/^local   all             all                                     peer/ s/peer/md5/' "/var/lib/pgsql/14/data/pg_hba.conf"

sudo sed -i "s/#listen_address.*/listen_addresses '*'/" "/var/lib/pgsql/14/data/postgresql.conf"

sudo systemctl restart postgresql-14.service

#add create DB