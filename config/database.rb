require 'sequel'

Config = {
  :database => {
    user:     'chase',
    password: '',
    host:     'localhost',
    port:     '5432',
    name:     'petsdb'
  }
}

DB = Sequel.postgres(
  user:     Config[:database][:user],
  password: Config[:database][:password],
  host:     Config[:database][:host],
  port:     Config[:database][:port],
  database: Config[:database][:name]
)
