create-db:
	mix ecto.create

migrate:
	mix ecto.migrate

migrate:
	mix ecto.drop

.PHONY: seed
seed:
	mix seed users roles articles courses lessons tags article_tag

# schema:
#	mix phx.gen.schema User users name:string email:string

server:
	mix phx.server

iex:
	iex -S mix phx.server

build-up: build up

build:
	docker-compose build

up:
	docker-compose up -d

down:
	docker-compose down