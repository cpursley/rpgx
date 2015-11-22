require 'colorize'
require 'erb'
require 'sequel'
require './config/database.rb'
require './app/routes.rb'
require './lib/dsl/routes_dsl.rb'
require 'require_all'
require_all 'app/handlers'

module RubyResty
  module RouteBuilder
    def self.escape_params(params)
      params.map { |param| "$escaped_#{param} $arg_#{param}" }
    end

    def self.route_template
      ERB.new(File.read("lib/nginx/conf/_route.erb"))
    end

    Routes.routes.each do |route|
      @partials = []
      @names    = []
      @route    = route[1]
      content   = route_template.result(binding)
      File.open("lib/nginx/conf/_#{route[0].to_s}_route", "w") { |file| file.puts content }
      @partials << content
      @names << @route[:name]
    end

    def self.template(type)
      case type
      when :error_codes
        ERB.new(File.read("lib/nginx/conf/_error_codes.erb"))
      when :nginx_conf
        ERB.new(File.read("lib/nginx/conf/nginx.conf.erb"))
      end
    end

    def self.build_routes
      @error_codes = template(:error_codes).result(binding)
      File.open("lib/nginx/conf/nginx.conf", "w") do |file|
        file.puts template(:nginx_conf).result(binding)
      end
      @names.each { |name| puts "/#{name}.json".colorize(:green) }
    end

    build_routes
    puts "<= Routes created".colorize(:blue)
  end
end
