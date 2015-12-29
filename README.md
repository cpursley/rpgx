RPGX
===========

## About

This is a simple yet performant framework for quickly creating REST(ish) JSON-APIs using Ruby as a DSL around OpenResty's [ngx_postgres](http://github.com/FRiCKLE/ngx_postgres) Postgres module. With this setup, Ruby is used similar to a static generator and not used at runtime (except for logging and jobs in a future iteration). Instead, business and display logic is handled by the database (via [Sequel](https://github.com/jeremyevans/sequel)-generated SQL) while routing is managed by the Route DSL. This approach, while it has limitations, allows for significant performance improvements over traditional Ruby rack-based web frameworks.

## Getting Started

- Install:
  - Postgres
    - Mac: PostgresApp or homebrew
  - [OpenResty](http://openresty.org/#Installation):
    - Mac OS: `brew install homebrew/nginx/openresty --with-postgresql`
    - [Docker (unverified)](https://github.com/ficusio/openresty)

## Demo
- Clone this repository
- Run `bundle install` to install Ruby dependencies
- Run `rake db:seed` to seed via the `db/seed.rb` file
- Run `rake routes:build` then `bin/rubyresty start` and open `localhost:8888/tweets`

## Commands
- OpenResty Server
  - `bin/rubyresty start`
  - `bin/rubyresty stop`

- OpenResty Console
  - `bin/rubyresty console`

- Create an empty Sequel migration file
  - `bin/rubyresty migration tweets`

#### Rake tasks
- Generate the OpenResty nginx.conf file:
  - `rake routes:build`

- Generate a Sequel migration:
  - `rake db:migrate:create`
  - `rake db:migrate:drop`
  - `rake db:migrate:up`
  - `rake db:migrate:down`
  - `rake db:migrate:reset`
  - `rake db:migrate:setup`

#### Usage
- Get tweets:   `CURL http://localhost:8888/tweets`
- Get a tweet:  `CURL http://localhost:8888/1`
- Create tweet: `CURL -X POST "http://localhost:8888/tweets?user_id=1&post='Wow, RubyResty is fast'"`
- Update tweet: `CURL -X PUT "http://localhost:8888/tweets/1?user_id=1&post='Even updates are fast!!'"`
- Delete tweet: `CURL -X DELETE http://localhost:8888/tweets/1`

## TODO

- [✓] Create basic Routing DSL
- [✓] Create rake db tasks and Thor commands
- [ ] Create better database and OpenResty config setup (yaml)
- [ ] Set up Celluloid [celluloid-io-pg-listener](https://github.com/pboling/celluloid-io-pg-listener)
- [ ] Add project folder/layout setup Thor command (`rubyresty new appname`)
- [ ] Convert files in lib folder to set of Ruby Gems
- [ ] Dockerize for easy bootstrapping (without need to manually install and configure OpenResty)
- [ ] Create Heroku-ready version
