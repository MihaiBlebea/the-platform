FROM elixir:1.10.0-alpine AS build

# install build dependencies
RUN apk add --no-cache build-base npm git python

# prepare build dir
WORKDIR /app

# set build ENV
ENV MIX_ENV=prod

ARG ARG_SECRET_KEY_BASE
ENV SECRET_KEY_BASE=${ARG_SECRET_KEY_BASE}

ARG ARG_MYSQL_USER
ENV MYSQL_USER=${ARG_MYSQL_USER}

ARG ARG_MYSQL_PASSWORD
ENV MYSQL_PASSWORD=${ARG_MYSQL_PASSWORD}

ARG ARG_MYSQL_DATABASE
ENV MYSQL_DATABASE=${ARG_MYSQL_DATABASE}

ARG ARG_MYSQL_HOST
ENV MYSQL_HOST=${ARG_MYSQL_HOST}

ARG ARG_MYSQL_PORT
ENV MYSQL_PORT=${ARG_MYSQL_PORT}

ARG ARG_SLACK_WEBHOOK
ENV SLACK_WEBHOOK=${ARG_SLACK_WEBHOOK}

ARG ARG_GITHUB_TOKEN
ENV GITHUB_TOKEN=${ARG_GITHUB_TOKEN}

ARG ARG_CONVERT_KIT_API_KEY
ENV CONVERT_KIT_API_KEY=${ARG_CONVERT_KIT_API_KEY}

ARG ARG_CONVERT_KIT_SECRET_KEY
ENV CONVERT_KIT_SECRET_KEY=${ARG_CONVERT_KIT_SECRET_KEY}

ARG ARG_CONVERT_KIT_FORM_ID
ENV CONVERT_KIT_FORM_ID=${ARG_CONVERT_KIT_FORM_ID}

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN mix do deps.get, deps.compile

# build assets
COPY assets/package.json assets/package-lock.json ./assets/
RUN npm --prefix ./assets ci --progress=false --no-audit --loglevel=error

COPY priv priv
COPY assets assets

RUN npm run --prefix ./assets deploy
RUN mix phx.digest

# compile and build release
COPY lib lib
# uncomment COPY if rel/ exists
# COPY rel rel
RUN mix do compile, release

# prepare release image
FROM alpine:3.9 AS app

RUN apk add --no-cache openssl ncurses-libs

WORKDIR /app

COPY start ./bin/start
RUN chmod +x ./bin/start

RUN chown nobody:nobody /app

USER nobody:nobody

COPY --from=build --chown=nobody:nobody /app/_build/prod/rel/platform ./

ENV HOME=/app

EXPOSE 4000

CMD ["bin/platform", "start"]