# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jesstava <jesstava@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/04/17 22:58:22 by jesstava          #+#    #+#              #
#    Updated: 2026/04/27 05:38:53 by jesstava         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

COMPOSE_FILE = srcs/docker-compose.yml

all:
	@mkdir -p /home/jesstava/data/wordpress
	@mkdir -p /home/jesstava/data/mariadb
	@mkdir -p /home/jesstava/data/portainer
	@docker compose -f $(COMPOSE_FILE) up -d --build

down:
	@docker compose -f $(COMPOSE_FILE) down

stop:
	@docker compose -f $(COMPOSE_FILE) stop

start:
	@docker compose -f $(COMPOSE_FILE) start

clean: down
	@docker system prune -f

fclean: clean
	@docker volume rm $$(docker volume ls -q) 2>/dev/null || true
	@sudo sh -c "rm -rf /home/jesstava/data/wordpress/*" 2>/dev/null || true
	@sudo sh -c "rm -rf /home/jesstava/data/mariadb/*" 2>/dev/null || true
	@sudo sh -c "rm -rf /home/jesstava/data/portainer/*" 2>/dev/null || true

re: fclean all

.PHONY: all down stop start clean fclean re
