create-db:
	mix ecto.create

migrate:
	mix ecto.migrate

drop:
	mix ecto.drop

.PHONY: seed
seed:
	mix seed users roles articles courses lessons tags article_tag

refresh: drop create-db migrate seed

# schema:
#	mix phx.gen.schema User users name:string email:string

server:
	mix phx.server

iex:
	iex -S mix phx.server

build-up: build up

build:
	cd ./deploy && docker-compose build

up:
	cd ./deploy && docker-compose up -d

.PHONY: config
config:
	cd ./deploy && docker-compose config

down:
	cd ./deploy && docker-compose down