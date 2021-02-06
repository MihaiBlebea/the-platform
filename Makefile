create-db:
	mix ecto.create

migrate:
	mix ecto.migrate

# schema:
#	mix phx.gen.schema User users name:string email:string

server:
	mix phx.server

iex:
	iex -S mix phx.server

build-up: build up

build:
	docker-compose build --no-cache

up:
	docker-compose up -d

down:
	docker-compose down