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

ps:
	$(COMPOSE) ps -a

logs:
	$(COMPOSE) logs -f

exec-bash:
	$(COMPOSE) exec -it ${ARG} bash

clean:
	docker system prune -a

re: down build up

.PHONY: all build up down restart ps logs exec-bash re