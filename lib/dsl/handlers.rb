require 'sequel'
require './config/database.rb'

module RubyResty
  class Handlers < Sequel::Model
    class << self
      Sequel.extension :inflector
      def escape_params(params)
        hashed_params = []
        params.each { |param| hashed_params << [param.to_sym, "$escaped_#{param.to_s}"] }
        hashed_params.to_h
      end

      def model(name)
        plural_name = name.to_s.pluralize
        instance_variable_set("@#{plural_name}", self.from(plural_name))
        instance_variable_set("@#{name}_id", escape_params(['id']))
      end

      def handler(name, &block)
        define_method(name) do
          self.class.instance_eval(&block).tr(%q{"'}, '')
        end
      end
    end
  end
end
