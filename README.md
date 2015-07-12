RPGX
===========

## About

This is the initial idea for a simple yet performant framework for quickly creating RESTful JSON-APIs using OpenResty's [ngx_postgres](http://github.com/FRiCKLE/ngx_postgres) module, Postgres and Ruby. At the moment, this is just OpenResty and Postgres (no Ruby), but the general idea is to use Ruby as a DSL that generates the nginx.conf file which contains routes and sql query and as a data mapper for building out the sql models.

With this setup, Ruby is used similar to a static generator and not needed at runtime. Instead, logic is handled by the database while routing is handled by Openresty. If that approach ends up unfeasible, another direction is to use Ruby dynamically similar to the Lua-based [Gin.io framework](http://gin.io/), still (hypothetically) allowing for significant performance improvements over traditional Ruby web frameworks.

## Getting Started

- Install OpenResty: [http://openresty.org/](http://openresty.org/)
- Seed database: `$ psql -U chase -d catdb -f db/catdb.sql`
- Start nginx: (this depends on your method of installation)

## TODO

- [ ] Dockerize for easy bootstrapping
- [ ] Choose Ruby ORM for creating models, functions & queries
- [ ] Create Ruby DSL and templating that compiles to nginx.conf file
