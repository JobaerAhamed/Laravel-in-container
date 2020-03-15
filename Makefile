PORT = 8080

default:
	docker-compose up

build:
	docker-compose build
	docker-compose up

build-init:
	make build-new
	gnome-terminal --tab -- /bin/bash -c "make build-setup; bash"

build-new:
	docker network create laravel-network
	docker-compose build --no-cache
	docker-compose up

build-setup:
	make enable-sh
	make composer c=install
	make php-artisan c=key:generate
	make php-artisan c=migrate

down:
	docker-compose down

enable-sh:
	find ./scripts -type f -exec chmod +x {} \;

container:
	./scripts/./container.sh $(c)

composer:
	./scripts/./composer.sh $(c)

php-artisan:
	./scripts/./php-artisan.sh $(c)

db:
	./scripts/./db.sh $(c)

phpunit:
	./scripts/./phpunit.sh $(c)

openinbrowser:
	sensible-browser http://127.0.0.1:$(PORT) &