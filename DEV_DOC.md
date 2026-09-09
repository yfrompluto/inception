*This project has been created as part of the 42 curriculum.*

# Set up the environment from scratch (prerequisites, configuration files, secrets).

* Prerequisites - to set up the environment, some tools must be installed on the VM :

- Docker -> to build the images and run containers
- Docker compose -> to manage the multi container stack
- Make -> to run the project
- git -> to clone the repository

* Some files must be configured :

- a .env file which contains all non-sensitive environment variable that Docker compose will inject into containers at run time. It allows full customisation (domain name : login.42.fr, services credentials..)

- a secrets directory (at the root of the project) which contains text files mounted as read-only and as tmpfs (RAM) -not on containers disk-, for any piece of sensitive data that should not be transmitted over a network nor be stored unencrypted in a Dockerfile/.env/git repository.

- the line '127.0.0.1 login.42.fr' should be added to '/etc/hosts' on the VM, in order to configure the domain.


# Building and launching the project using the Makefile and Docker Compose.

The makefile at the root of the project wraps useful Docker compose commands : 
`make all` -> To start the project : it will build the images, start all containers, create the volumes and launch the project.
`make stop` -> To pause containers without deleting them 
`make start`-> To resume paused containers
`make down` -> To stop containers while keeping persistent data
`make fclean`-> To stop containers and delete all persistent data 
`make re` -> To fully rebuild the project

Docker compose is a CLI tool for defining/running multi-container applications. It reads srcs/docker-compose.yml to know which services to build, how to connect them, and which networks/volumes to create.

Each service has its own Dockerfile, Docker compose builds each image. create the named volumes and the docker network linking these services together. Then containers will start in the correct dependency orders to avoid conflicts, 

# Relevant commands to manage the containers and volumes.

`docker ps` -> To show running containers (All three containers (nginx, wordpress, mariadb) should show 'UP' status.)
`docker logs -container name-` -> To see a specific service's logs at the time of execution
`docker volume ls` -> To see all the volume known to Docker
`docker exec -it <..> sh` -> To start a new shell session inside the container
`docker volume inspect <volume>` -> To show mountpoint and metadata

# Identify where the project data is stored and how it persists.

Volumes are persistent data stores implemented by the container engine that can be configured and reused across multiple services. A Docker volume is an independent file system entirely managed by the Docker daemon that exists as a regular file or directory on the host.
A named volume is explicitly declared in docker-compose.yml. The subject requires that both mandatory volumes store their data inside /home/login/data/ on the host.

- `srcs_wordpress_data` → mounted at `/var/www/html` in wordpress and nginx
- `srcs_mariadb_data` → mounted at `/var/lib/mysql` in mariadb

After running make down, containers are stopped and removed but volumes remain intact. The next make all restarts containers and remounts the same data—the site and database are exactly as they were.

Otherwise, everything inside a container—installed packages, temporary files, runtime usage—is lost when the container is removed. Only data explicitly written to a mounted volume persists.
