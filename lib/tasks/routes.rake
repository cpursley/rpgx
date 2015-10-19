require 'sequel'

namespace :build do
  desc "Seed database"
  task :routes do
    ruby './app/routes.rb'
    puts 'Routes created'
  end
end
