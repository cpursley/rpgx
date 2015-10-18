require 'erb'
require 'active_record'
require './app/models/cat.rb'

# # DB Config
config = {
  :database => {
    name:     'catdb',
    user:     'chase',
    password: ''
  }
}

# data
params = %w(name karma vip)
# params
mapped_params = params.map { |param| "$#{param} $arg_#{param}" }

def resty(query)
  query.to_sql.tr(%q{"'}, '')
end

# This is the rudimentary predecessor to a "Routes" DSL
resources = {
  :cats => {
    name: 'cats',
    handlers: {
      get_all: resty(Cat.get_cats),
      post:    resty(Cat.create_cat),
      get:     resty(Cat.get_cat),
      put:     resty(Cat.update_cat),
      delete:  resty(Cat.destroy_cat)
    }
  }
}

# how can we loop through partials for multiple routes??
route = resources[:cats]

# routes
route_template = ERB.new(File.read("conf/_route.erb"))
route_content  = route_template.result(binding)
File.open("conf/_route", "w") { |file| file.puts route_content }

nginx_template = ERB.new(File.read("conf/nginx.conf.erb"))
nginx_conf     = nginx_template.result(binding)
File.open("conf/nginx.conf", "w") { |file| file.puts nginx_conf }
puts "#{route[:name].capitalize} routes created..."

puts resty(Cat.destroy_cat)
