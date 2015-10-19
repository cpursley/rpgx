# http://obfuscurity.com/2011/11/Sequel-Migrations-on-Heroku
require 'sequel'
database_name = 'catdb'
database_user = 'chase'

DB = Sequel.postgres(
  :user     => "#{database_user}",
  :password => "",
  :host     => "localhost",
  :port     => '5432',
  :database => "#{database_name}"
)

namespace :db do
  require 'sequel'
  namespace :migrate do
    Sequel.extension :migration

    desc "Perform migration reset (full erase and migration up)"
    task :reset do
      Sequel::Migrator.run(DB, "db/migrations", :target => 0)
      Sequel::Migrator.run(DB, "db/migrations")
      puts "<= sq:migrate:reset executed"
    end

    desc "Perform migration up/down to VERSION"
    task :to do
      #version = ENV['VERSION'].to_i
      version = 5.to_i
      raise "No VERSION was provided" if version.nil?
      Sequel::Migrator.run(DB, "db/migrations", :target => version)
      puts "<= sq:migrate:to version=[#{version}] executed"
    end

    desc "Perform migration up to latest migration available"
    task :up do
      Sequel::Migrator.run(DB, "db/migrations")
      puts "<= sq:migrate:up executed"
    end

    desc "Perform migration down (erase all data)"
    task :down do
      Sequel::Migrator.run(DB, "db/migrations", :target => 0)
      puts "<= sq:migrate:down executed"
    end
  end
end
