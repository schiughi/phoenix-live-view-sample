FROM elixir:latest

ENV NODE_VERSION 11.x
ENV NPM_VERSION 6.7.0

RUN curl -sL https://deb.nodesource.com/setup_${NODE_VERSION} | bash \
  && apt-get install -y nodejs

RUN npm install npm@${NPM_VERSION} -g

RUN apt-get install -y inotify-tools

RUN mix local.hex --force && \
  mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phx_new.ez && \
  mix local.rebar --force
RUN mix deps.get --only prod
RUN mix deps.compile
RUN mix compile

WORKDIR /app
