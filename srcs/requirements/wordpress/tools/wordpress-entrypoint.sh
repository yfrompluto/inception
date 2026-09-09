#!/bin/sh

db_pw=$(cat /run/secrets/db_password)
wp_user_pw=$(cat /run/secrets/wp_user_password)
wp_admin_pw=$(cat /run/secrets/credentials)

while ! mariadb-admin ping -h mariadb -u $MYSQL_USER  -p"$db_pw" 2>/dev/null; do
	sleep 1
done

if [ ! -f /var/www/html/wp-login.php ]; then
	wp core download --path=/var/www/html/ --allow-root
	wp config create --path=/var/www/html --dbname="$MYSQL_DATABASE" --dbuser="$MYSQL_USER" --dbpass="$db_pw" --dbhost=mariadb --allow-root;
	
	wp config set WP_REDIS_HOST redis --allow-root --path=/var/www/html
	wp config set WP_REDIS_PORT 6379 --allow-root --path=/var/www/html

	wp core install --path=/var/www/html --url="$DOMAIN_NAME" --title="pluto" --admin_user="$WP_ADMIN" --admin_password="$wp_admin_pw" --admin_email="$WP_ADMIN_EMAIL" --allow-root
	wp user create --path=/var/www/html $WP_USER $WP_USER_EMAIL --role=author --user_pass="$wp_user_pw" --allow-root
	
	wp plugin install redis-cache --activate --allow-root --path=/var/www/html
	wp redis enable --allow-root --path=/var/www/html	
	
	sleep 3
fi

exec php-fpm83 -F 
