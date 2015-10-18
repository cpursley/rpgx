require 'erb'
require 'sequel'
require './app/models/cat.rb'

# Config
config = {
  :database => {
    name:     'catdb',
    user:     'chase',
    password: ''
  }
}

# Predecessor to a "Routes" DSL
resources = {
  :cats => {
    name: 'cats',
    params: %w(name karma vip),
    handlers: {
      get_all: Cat.get_cats,
      post:    Cat.create_cat,
      get:     Cat.get_cat,
      put:     Cat.update_cat,
      delete:  Cat.delete_cat
    }
  }
}

# route utility methods
def escape_params(params)
  params.map { |param| "$escaped_#{param} $arg_#{param}" }
end

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

# puts resty(Cat.get_cats)
puts Cat.get_cat
