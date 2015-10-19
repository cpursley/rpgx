require 'sequel'

namespace :db do
  desc "Seed database"
  task :seed do
    ruby './db/seed.rb'
  end
end
