#!/bin/bash
args="$@"
command="composer $args"
echo "$command"
docker exec -it laravel-app bash -c "$command"