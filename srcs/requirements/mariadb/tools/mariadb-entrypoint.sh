#!/bin/sh
set -e

db_pw=$(cat /run/secrets/db_password)
db_root_pw=$(cat /run/secrets/db_root_password)

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

if [ ! -d /var/lib/mysql/mysql ]; then
    echo ">>> Initializing MariaDB database..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql > /dev/null 2>&1

    cat > /tmp/init.sql << EOF
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${db_pw}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${db_root_pw}';
FLUSH PRIVILEGES;
EOF

    echo ">>> Starting MariaDB with init file..."
    exec mariadbd --user=mysql --datadir=/var/lib/mysql --init-file=/tmp/init.sql
fi

echo ">>> Starting MariaDB..."
exec mariadbd --user=mysql --datadir=/var/lib/mysql
