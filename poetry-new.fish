#!/usr/bin/env fish

function do_func
  argparse -n do_func 'h/help' 'o/option=' -- $argv
  or return 1

  if set -lq _flag_help
    echo 'poetry-new.fish -o/--option <DOCKER_BASE_IMAGE>'
    return
  end

  set -lq _flag_option
  or set -l _flag_option 'python:3.12.1-slim-bullseye'
  #or set -l _flag_option '/dev/stdout'

  docker run \
    --rm \
    --volume $(pwd):/app \
    --workdir /app \
    $_flag_option bash -c \
    'pip install poetry && poetry new my_project && cd $_ && poetry install'
end

do_func $argv
