require 'erb'

# This is the rudimentary predecessor to a "Routes" DSL

# variables
database_name = 'catdb'
database_user = 'chase'
base_model    = 'cats'
route         = base_model

# data
params = %w(name about)
insert = params.join(",")
values = params.map { |param| "$#{param}" }.join(",")
update = params.map { |param| "#{param}=$#{param}" }.join(",")

# params
post_params = params.map { |param| "$#{param} $arg_#{param}" }
put_params  = post_params

# queries
get_all       = "SELECT * FROM #{base_model}"
post_model    = "INSERT INTO #{base_model} (#{insert}) VALUES (#{values}) RETURNING *"
get_model     = "SELECT * FROM #{base_model} WHERE id=$escaped_id"
update_model  = "UPDATE #{base_model} SET #{update} WHERE id=$escaped_id RETURNING *"
destroy_model = "DELETE FROM #{base_model} WHERE id=$escaped_id"

# routes
route_template = ERB.new(File.read("conf/_route.erb"))
route_content  = route_template.result(binding)
File.open("conf/_route", "w") { |file| file.puts route_content }

nginx_template = ERB.new(File.read("conf/nginx.conf.erb"))
nginx_conf    = nginx_template.result(binding)
File.open("conf/nginx.conf", "w") { |file| file.puts nginx_conf }
