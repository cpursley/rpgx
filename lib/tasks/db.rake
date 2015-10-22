require 'sequel'
require './config/database.rb'

namespace :db do
  require 'sequel'
  namespace :migrate do
    Sequel.extension :migration
    db   = Config[:database]
    opts = DB.opts

    desc "Create database if does not exist"
    task :create do
      begin
        system "createdb #{db[:name]} -h #{db[:host]} -p #{db[:port]} -U #{db[:user]}"
        if $?.exitstatus == 0
          puts "<= #{db[:database]} database has been successfully created!"
        end
      rescue Sequel::DatabaseError => e
        puts "<= #{e}"
      end
    end

    desc "Drop database if it exists"
    task :drop do
      begin
        system "dropdb -h #{opts[:host]} -p #{opts[:port]} -U #{opts[:user]} #{opts[:database]}"
        if $?.exitstatus == 0
          puts "<= #{opts[:database]} database has been successfully dropped!"
        end
      rescue Sequel::DatabaseError => e
        puts "<= #{e}"
      end
    end

    desc "Perform migration up to latest migration available"
    task :up do
      Sequel::Migrator.run(DB, "db/migrations")
      puts "<= #{db[:database]} database has been successfully migrated up"
    end

    desc "Perform migration down (erase all data)"
    task :down do
      Sequel::Migrator.run(DB, "db/migrations", :target => 0)
      puts "<= #{db[:database]} database has been successfully migrated down"
    end

    desc "Perform migration reset (full erase and migration up)"
    task :reset do
      begin
        Sequel::Migrator.run(DB, "db/migrations", :target => 0)
        Sequel::Migrator.run(DB, "db/migrations")
        puts "<= #{db[:database]} database has been successfully reset"
      rescue Sequel::DatabaseError => e
        puts "<= #{e}"
      end
    end

    desc "Create, migrate and seed database"
    task :setup do
      tasks = %i(drop create down up)
      tasks.each do |task|
        Rake::Task["db:migrate:#{task}"].invoke
      end
      Rake::Task["db:seed"].invoke
      puts "<= Successfully created, migrated and seeded #{opts[:database]}"
    end
  end
end
