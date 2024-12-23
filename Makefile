NAME := inception
COMPOSE := docker-compose -f srcs/docker-compose.yml

all: build up

build:
	$(COMPOSE) build

up:
	$(COMPOSE) up -d

down:
	$(COMPOSE) down

restart: down up

certs:
	@sudo cp /etc/hosts /etc/hosts.backup
	@sudo chmod 777 /etc/hosts
	@sudo echo "127.0.0.1 shmorish.42.fr" >> /etc/hosts
	@sudo chmod 644 /etc/hosts

ps:
	$(COMPOSE) ps -a

logs:
	$(COMPOSE) logs -f

x:
	docker exec -it nginx bash

wp:
	docker exec -it wordpress bash

db:
	docker exec -it mariadb bash

clean:
	@$(COMPOSE) down --rmi all --volumes --remove-orphans
	@docker system prune -a
	@sudo rm -rf ~/data/db ~/data/web

re: down all

.PHONY: all build up down restart ps logs re clean x wp db