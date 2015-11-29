RPGX
===========

## About

This is the initial idea for a simple yet performant framework for quickly creating RESTful JSON-APIs using Ruby as a DSL around OpenResty's [ngx_postgres](http://github.com/FRiCKLE/ngx_postgres) Postgres module. With this setup, Ruby is used similar to a static generator and not used at runtime (except for potentially logging and jobs in a future iteration). Instead, business and display logic is Handled by the database (via [Sequel](https://github.com/jeremyevans/sequel) or plain SQL) while routing is managed by the Route DSL. This approach, while it has limitations, allows for significant performance improvements over traditional Ruby rack-based web frameworks.

## Getting Started

- Install [OpenResty](http://openresty.org/#Installation):
  - Mac OS: `brew install homebrew/nginx/openresty --with-postgresql`
  - [Docker (unverified)](https://github.com/ficusio/openresty)

## Demo
- For now, use with this example database: [postgres-twitter](https://github.com/shuber/postgres-twitter) until it's completely ported to this repository
- Clone the above repository, cd in, run the *compile* task, then `$ psql -U yourusername -f compiled.sql`
- Come back to the rpgx repository and run `rake db:seed` to seed via the `db/seed.rb` file
- Run `rake routes:build` then `bin/rubyresty start` and open `localhost:8888/tweets`

## Commands
- OpenResty Sever
  - `bin/rubyresty start`
  - `bin/rubyresty stop`

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

## TODO

- [✓] Create basic Routing DSL
- [✓] Create rake db tasks and Thor commands
- [ ] Add project folder/layout setup command (`rubyresty new appname`)
- [ ] Set up Celluloid [celluloid-io-pg-listener](https://github.com/pboling/celluloid-io-pg-listener)
- [ ] Convert lib folder to Ruby Gem
- [ ] Dockerize for easy bootstrapping (without need to manually configure OpenResty)
- [ ] Make Heroku-ready
