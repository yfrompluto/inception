#!/bin/sh

set -e

ftp_pw=$(cat /run/secrets/ftp_password)

if ! id ftpuser > /dev/null 2>&1; then
	adduser -h /var/www/html -s /bin/false -D ftpuser
fi

echo "ftpuser:$ftp_pw" | chpasswd

mkdir -p /var/run/vsftpd/empty
echo ftpuser > /etc/vsftpd.userlist

exec vsftpd /etc/ftp/ftp.conf
