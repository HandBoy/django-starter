SETTINGS := develop

help: 	## Show this help.
	@echo "Please use \`make <target>' where <target> is one of"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?##"}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

deploy: ## Builds Docker images from a Dockerfile setting a enviroment. 
	docker-compose build --build-arg APP_ENVIROMENT="$(SETTINGS)"

up:		## Builds, (re)creates, starts, and attaches to containers for a service web.
	docker-compose up web

down:	## Stops containers and removes containers, networks, volumes, and images created by up.
	docker-compose down

test:	## Run project tests
	docker-compose run web py.test

migration: ## Generate Django migrations
	docker-compose run web python src/manage.py makemigrations

migrate:   ## Apply Django migrations
	docker-compose run web python src/manage.py  migrate

clean:	## remove all ".pyc" files
	-rm -rf htmlcov
	-rm -rf .coverage
	-rm -rf .pytest_cache

run: deploy