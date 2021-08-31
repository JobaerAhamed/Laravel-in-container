default:
	docker-compose up

build:
	docker-compose build
	docker-compose up

build-new:
	docker-compose down | true
	docker volume rm laravel-in-container_db | true
	docker volume rm laravel-in-container_db-replica | true
	docker network rm laravel-network | true
	docker network create laravel-network
	docker-compose build --no-cache
	docker-compose up

build-setup:
	make enable-sh
	npm install -E
	make composer c=install
	make php-artisan c=key:generate
	make php-artisan c=migrate
	docker-compose exec mysql-replica bash -c 'chmod +x ./etc/mysql/start_replica.sh && ./etc/mysql/start_replica.sh && mysql -uroot -p$$MYSQL_ROOT_PASSWORD < "/etc/mysql/start_replica.sql"'

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

exec:
	docker exec -it laravel-app bash -c "$(command)"

update-replica:
	docker-compose exec mysql-replica bash -c 'mysql -uroot -p$$MYSQL_ROOT_PASSWORD -e "STOP SLAVE; CHANGE MASTER TO MASTER_DELAY=${delay}; START SLAVE;"'

watch-replica:
	docker-compose exec mysql-replica bash -c 'mysql -uroot -p$$MYSQL_ROOT_PASSWORD -e "SHOW SLAVE STATUS\\G;"'
