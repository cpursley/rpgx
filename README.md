RPGX
===========

## About

This is the initial idea for a simple yet performant framework for quickly creating RESTful JSON-APIs using OpenResty's [ngx_postgres](http://github.com/FRiCKLE/ngx_postgres) module, Postgres and Ruby. At the moment, this is just OpenResty and Postgres, but the general idea is to use Ruby as a DSL that generates the nginx.conf file which contains routes and sql query and as a data mapper for building out the sql models.

With this setup, Ruby is used similar to a static generator and not needed at runtime. Instead, logic is handled by the database while routing is handled by OpenResty. If that approach is unfeasible, another direction is to use dynamic Ruby similar to Lua-based [Gin.io](http://gin.io/), which would allow for significant performance improvements over traditional Ruby web frameworks.

## Getting Started

- Install OpenResty: [http://openresty.org/](http://openresty.org/)
- Seed database: `$ psql -U chase -f db/catdb.sql`
- Create the routes: `$ ruby routes.rb`
- Start nginx: (this depends on your method of installation)
- alias "rpgx-start"="/usr/local/openresty/nginx/sbin/nginx -p `pwd`/ -c conf/nginx.conf"

## TODO

- [ ] Dockerize for easy bootstrapping
- [ ] Choose Ruby ORM for creating models, functions & queries
- [ ] Create Ruby DSL and templating that compiles to nginx.conf file
