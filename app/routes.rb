require     'sequel'
require     './config/database.rb'
require     'erb'
require     './lib/dsl/routes.rb'
require     'require_all'
require_all 'app/handlers'

# API DSL ideas
# module CatsAPI
#   include RubyResty::Routes
#
#   let(:cats_handler) { CatHandler }
#
#   api_version "V1.0" # or namespace ??
#     route :cats do # cats.json
#       get  { handler: cats_handler.get_cats,   desc: "Return all Cats." }
#       post { handler: cats_handler.create_cat, desc: "Create a Cat." }
#       param :id do # cats/:id.json
#         get    { handler: cats_handler.get_cat,    desc: "Return a Cat." }
#         put    { handler: cats_handler.update_cat, desc: "Update a Cat." }
#         delete { handler: cats_handler.delete_cat, desc: "Delete a Cat." }
#       end
#       route :updated do # cats/updated.json
#         get { handler: cats_handler.updated_cats, desc: "Return recently updated Cats." }
#       end
#       route :karma do # cats/karma.json
#         get { handler: cats_handler.top_karma,    desc: "Return Cats with top Karma." }
#         put { handler: cats_handler.update_karma, desc: "Update a Cat's Karma." }
#       end
#     end
#   end
# end

# 'desc' should get printed when running: resty routes:show

# use rlet for these
cat_handler = CatHandler
dog_handler = DogHandler

# https://stackoverflow.com/questions/6872596/ruby-hash-tree-with-blocks
routes = Routes.build {
  cats do
    name :cats
    params %w(name karma vip) # Set this up in handlers as params method.
    handlers do
      get_all cat_handler.get_cats
      post    cat_handler.create_cat
      get     cat_handler.get_cat
      put     cat_handler.update_cat
      delete  cat_handler.delete_cat
    end
  end

  dogs do
    name :dogs
    params %w(name paws vip)
    handlers do
      get_all dog_handler.get_dogs
      post    dog_handler.create_dog
      get     dog_handler.get_dog
      put     dog_handler.update_dog
      delete  dog_handler.delete_dog
    end
  end
}

# Move to route utility module
def escape_params(params)
  params.map { |param| "$escaped_#{param} $arg_#{param}" }
end

# partials (ditto)
@partials = []
routes.each do |route|
  @route = route[1]
  route_template = ERB.new(File.read("lib/nginx/conf/_route.erb"))
  @content  = route_template.result(binding)
  File.open("lib/nginx/conf/_#{route[0].to_s}_route", "w") { |file| file.puts @content }
  @partials << route_template.result(binding)
end

# error codes (ditto)
error_partial = ERB.new(File.read("lib/nginx/conf/_error_codes.erb"))
@error_codes  = error_partial.result(binding)

nginx_template = ERB.new(File.read("lib/nginx/conf/nginx.conf.erb"))
nginx_conf     = nginx_template.result(binding)
File.open("lib/nginx/conf/nginx.conf", "w") { |file| file.puts nginx_conf }
