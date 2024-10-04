include	.envs/.mlflow-common
include	.envs/.mlflow-dev
include	.envs/.postgres
export

DOCKER_COMPOSE_RUN=docker-compose run --rm mlflow-server
lock-dependencies:BUILD_POETRY_LOCK=/poetry.lock.build

## Build docker containers with docker-compose
build:	
  docker-compose build

## docker-compose up -d
up:
  docker-compose up -d

## docker-compose down
down: 
  docker-compose down

## docker exec -it mlflow-tracking-server bash
exec-in: up
  docker exec -it local-mlflow-tracking-server bash

## Lock dependencies with pipenv
lock-dependencies:
  $(DOCKER_COMPOSE_RUN) bash -c "if [ -e ${BUILD_POETRY_LOCK} ]; then cp ${BUILD_POETRY_LOCK} ./poetry.lock; else poetry lock; fi"
