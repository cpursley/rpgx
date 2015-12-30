require 'colorize'
require 'sequel'
require './lib/config/database.rb'

namespace :db do
  require 'sequel'
  namespace :migrate do
    Sequel.extension :migration

    desc "Create database if does not exist"
    task :create do
      begin
        system "createdb #{DB.opts[:name]} -h #{DB.opts[:host]} -p #{DB.opts[:port]} -U #{DB.opts[:user]}"
        if $?.exitstatus == 0
          puts "<= #{DB.opts[:database]} database has been successfully created!".colorize(:green)
        end
      rescue Sequel::DatabaseError => e
        puts "<= #{e}".colorize(:red)
      end
    end

    desc "Drop database if it exists"
    task :drop do
      begin
        system "dropdb -h #{DB.opts[:host]} -p #{DB.opts[:port]} -U #{DB.opts[:user]} #{DB.opts[:database]}"
        if $?.exitstatus == 0
          puts "<= #{DB.opts[:database]} database has been successfully dropped!".colorize(:green)
        end
      rescue Sequel::DatabaseError => e
        puts "<= #{e}".colorize(:red)
      end
    end

    desc "Perform migration up to latest migration available"
    task :up do
      begin
        Sequel::Migrator.run(DB, "db/migrations")
        puts "<= #{DB.opts[:database]} database has been successfully migrated up".colorize(:green)
      rescue Sequel::DatabaseError => e
        puts "<= #{e}".colorize(:red)
      end
    end

    desc "Perform migration down (erase all data)"
    task :down do
      begin
        Sequel::Migrator.run(DB, "db/migrations", :target => 0)
        puts "<= #{DB.opts[:database]} database has been successfully migrated down".colorize(:green)
      rescue Sequel::DatabaseError => e
        puts "<= #{e}".colorize(:red)
      end
    end

    desc "Perform migration reset (full erase and migration up)"
    task :reset do
      begin
        Sequel::Migrator.run(DB, "db/migrations", :target => 0)
        Sequel::Migrator.run(DB, "db/migrations")
        puts "<= #{DB.opts[:database]} database has been successfully reset".colorize(:green)
      rescue Sequel::DatabaseError => e
        puts "<= #{e}".colorize(:red)
      end
    end

    desc "Create, migrate and seed database"
    task :setup do
      tasks = %i(drop create down up)
      tasks.each do |task|
        Rake::Task["db:migrate:#{task}"].invoke
      end
      Rake::Task["db:seed"].invoke
      puts "<= Successfully created, migrated and seeded #{DB.opts[:database]}".colorize(:green)
    end
  end
end
