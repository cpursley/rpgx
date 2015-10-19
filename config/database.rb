require 'sequel'

config = {
  :database => {
    user:     'chase',
    password: '',
    host:     'localhost',
    port:     '5432',
    name:     'catdb'
  }
}

DB = Sequel.postgres(
  user:     config[:database][:user],
  password: config[:database][:password],
  host:     config[:database][:host],
  port:     config[:database][:port],
  database: config[:database][:name]
)
