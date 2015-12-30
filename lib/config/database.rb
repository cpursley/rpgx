require 'sequel'
require 'yaml'
require 'dotenv'
Dotenv.load

DATABASE_CONFIG = YAML.load_file("./config/database.yml")

DB =
  case
  when ENV['RESTY_ENV'] == 'development'
    Sequel.postgres(DATABASE_CONFIG['development'])
  when ENV['RESTY_ENV'] == 'staging'
    Sequel.postgres(DATABASE_CONFIG['staging'])
  when ENV['RESTY_ENV'] == 'production'
    Sequel.postgres(DATABASE_CONFIG['production'])
  end

Sequel.extension :constraint_validations
