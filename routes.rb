require 'erb'
require 'sequel'
require 'sql-maker'

# This is the rudimentary predecessor to a "Routes" DSL

# DB Config
database_name = 'catdb'
database_user = 'chase'
DB = Sequel.connect(
  :adapter=>  'postgres',
  :host=>     'localhost',
  :database=> "#{database_name}",
  :user=>     "#{database_user}",
  :password=> '',
  :port=>     '5432'
)

table_name    = 'cats'
route         = table_name

# data
params = %w(name about)
joined_params = params.join(",")
values = params.map { |param| "$#{param}" }.join(",")
update = params.map { |param| "#{param}=$#{param}" }.join(",")

# params
post_params = params.map { |param| "$#{param} $arg_#{param}" }
put_params  = post_params

# queries
sql_builder = SQL::Maker::Select.new(:quote_char => '"', :auto_bind => true)

def all(sql_builder, table_name)
  sql_builder.add_select("#{table_name}.*")
             .add_from("#{table_name}")
             .add_where("#{table_name}.deleted_at" => nil)
             .as_sql
             .tr('"', '')
end

get_all = all(sql_builder, table_name)

post    = "INSERT INTO #{table_name} (joined_params) VALUES (#{values}) RETURNING *"
get     = "SELECT #{table_name}.* FROM #{table_name} WHERE #{table_name}.deleted_at IS NULL AND #{table_name}.id=$escaped_id LIMIT 1"
update  = "UPDATE #{table_name} SET #{update} WHERE #{table_name}.id=$escaped_id RETURNING *"
destroy = "DELETE FROM #{table_name} WHERE id=$escaped_id"

# routes
route_template = ERB.new(File.read("conf/_route.erb"))
route_content_1  = route_template.result(binding)
route_contents = []
route_contents << route_content_1
route_contents.each do |route_content|
  File.open("conf/_route_#{route}", "w") { |file| file.puts route_content }
end

nginx_template = ERB.new(File.read("conf/nginx.conf.erb"))
nginx_conf    = nginx_template.result(binding)
File.open("conf/nginx.conf", "w") { |file| file.puts nginx_conf }
