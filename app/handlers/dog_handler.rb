require 'active_record'
require 'sequel'
require './config/database.rb'

class DogHandler < Sequel::Model
  @dogs   = self.from(:dogs)
  @params = %w(name paws vip)
  @id = ['id']

  def self.get_dogs
    resty DB[:dogs_view].sql
  end

  def self.create_dog
    resty @dogs.insert_sql(hash_params(@params))
  end

  def self.get_dog
    resty @dogs.where(hash_params(@id)).sql
  end

  def self.update_dog
    resty @dogs.where(hash_params(@id)).update_sql(hash_params(@params))
  end

  def self.delete_dog
    resty @dogs.where(hash_params(@id)).delete_sql
  end

  # turn into let
  def self.params
    @params
  end

  private
  # handler utility methods ~ move to lib library module
  def self.resty(query)
    query.tr(%q{"'}, '')
  end

  def self.hash_params(params)
    hashed_params = []
    params.each { |param| hashed_params << [param.to_sym, "$escaped_#{param.to_s}"] }
    hashed_params.to_h
  end
end
