#!/bin/bash

args="$@"
command="php artisan $args"
echo "$command"
docker exec -it laravel-app bash -c "$command"
