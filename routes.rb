require 'erb'

# This is the rudimentary predecessor to a "Routes" DSL

# variables
database_name = 'catdb'
database_user = 'chase'
base_model    = 'cats'

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


# run in console to create nginx routes: `ruby routes.rb`
nginx_conf = ERB.new(File.read("conf/nginx.conf.erb"))

content = nginx_conf.result(binding)

File.open("conf/nginx.conf", "w") { |file| file.puts content }
