NAME := inception
COMPOSE := docker-compose -f srcs/docker-compose.yml

all: build up

build:
	@mkdir -p srcs/data/mariadb
	@mkdir -p srcs/data/wordpress
	$(COMPOSE) build

up:
	$(COMPOSE) up -d

down:
	@rm -rf srcs/data/
	$(COMPOSE) down

restart: down up

ps:
	$(COMPOSE) ps -a

logs:
	$(COMPOSE) logs -f

exec-bash:
	$(COMPOSE) exec -it ${ARG} bash

clean:
	$(COMPOSE) down --rmi all --volumes --remove-orphans
	docker system prune -a

re: down build up

.PHONY: all build up down restart ps logs exec-bash re