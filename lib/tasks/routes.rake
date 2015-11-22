namespace :routes do
  desc "Seed database"
  task :build do
    ruby './lib/dsl/route_builder.rb'
  end
end
