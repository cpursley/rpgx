require 'active_record'
require 'sequel'
require './config/database.rb'

class Cat < Sequel::Model
  @cats   = self.from(:cats)
  @params = %w(name karma vip)
  @id = ['id']

  def self.get_cats
    resty DB[:cats_view].sql
  end

  def self.create_cat
    resty @cats.insert_sql(hash_params(@params))
  end

  def self.get_cat
    resty @cats.where(hash_params(@id)).sql
  end

  def self.update_cat
    resty @cats.where(hash_params(@id)).update_sql(hash_params(@params))
  end

  def self.delete_cat
    resty @cats.where(hash_params(@id)).delete_sql
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
