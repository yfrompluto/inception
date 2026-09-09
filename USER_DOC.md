*This project has been created as part of the 42 curriculum.*

##  Services provided by the stack

This infrastructure provides a Wordpress website accessible via HTTPS. Three services run in the background:
MARIA DB - the database storing all wordpress data :
This service is a community-developed fork of the MySQL relational database management system led by the original developers of MySQL. Ity stores all the wordpress data-users, settings, posts, etc...

NGINX - the web server, sole entry point via 443 :
This open-source is a high-performance web server and reverse proxy server widely used for its speed, stability and low resource usage. It is designed to handle all incoming HTTP/HTTPS traffic with minimal resource consumption, while managing security features such as SSL/TLS to ensure encrypted traffic.

WORDPRESS - the website and its administration panel:
This open-source is a powerfull and flexible web content publishing software built on PHP by MySQL/MariaDB. It is the main website of this project, allowing an administrator to manage posts, users, plugins, customisations...


## Start and stop the project

Docker and docker compose must be installed in the virtual machine.
And the inception folder downloaded or git cloned too.
A .env file must be created at the root of the project for personalised data, as well as a secrets/ folder that must contain all required secrets files. 

From the project root directory: 
`make all` -> To start the project : it will build the images, start all containers, create the volumes and launch the project.

`make stop` -> To pause containers without deleting them 

`make start`-> To resume paused containers

`make down` -> To stop containers while keeping persistent data

`make fclean`-> To stop containers and delete all persistent data 


## Check that the services are running correctly

`docker ps` -> To show running containers (All three containers (nginx, wordpress, mariadb) should show 'UP' status.)

`docker logs -container name-` -> To see a specific service's logs of present at the time of execution

`docker volume ls` -> To see all the volume known to Docker

`git status --ignored ` -> To see all files ignored by git

- specifically to mariaDB
* to log into the mariadb/mysql server from inside the container :       
	`docker exec -it mariadb sh` 
	`mariadb -u root -p`

* useful commands to navigate inside the mariadb server :
	`SHOW DATABASES`, `USE wordpress`, `SHOW TABLES`

- specifically to mariaDB
Once the stack is running, you can go to https://login.42.fr in your browser, everything should load correctly. To confirm the admin panel is working, log in at https://login.42.fr/wp-admin using the admin credentials.


## Access the website and the administration panel.

The website is accessible at https://login.42.fr , Accept the self-signed certificate warning.
To access the administration panel, you can either browse the website or access it throught the URL at https://login.42.fr/wp-admin. It will then ask for the admin credentials. 
Once logged in, the administrator can edit posts, approve comments, manage the Redis cache plugin, edit the website appearance and more.


## Locate and manage credentials.

For integrity, confidentiality and availability matters, all credentials are stored inside secrets/ folder and ignored by git. Less sensitive configuration values that can be personalised (domain name, database name, etc..) are located in the .env file at the root of the project. To update a credential, you must rebuild and restart the project after editing. You shall never commit the secrets/ folder or .env file publicly.
