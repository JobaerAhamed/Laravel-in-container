#!/usr/bin/env sh

cat >/etc/mysql/start_replica.sql <<EOL
DROP USER 'user'@'%';

STOP SLAVE;

CHANGE MASTER TO MASTER_HOST='mysql-db', MASTER_USER='root', MASTER_PASSWORD='pass', MASTER_LOG_FILE='mysql-bin.000001', MASTER_LOG_POS=0, MASTER_DELAY=0;

START SLAVE;

EOL
