require 'sequel'

# change to rake routes:build
namespace :build do
  desc "Seed database"
  task :routes do
    ruby './app/routes.rb'
    puts 'Routes created'
  end
end

# create tool for showing routes ~ i.e., rake routes:show

# actually, move this to thor so: resty routes:build, rest routes:show
# this should also print out the 'desc' message if it exists
