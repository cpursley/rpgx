require 'active_record'
require 'sequel'

# # DB Config
database_name = 'catdb'
database_user = 'chase'

DB = Sequel.postgres(
  :user     => "#{database_user}",
  :password => "",
  :host     => "localhost",
  :port     => '5432',
  :database => "#{database_name}"
)

# DB.create_table :cats do
#   primary_key :id
#   String      :name,  null: false, size: 255
#   Integer     :karma, null: false, default: 0
#   FalseClass  :vip
# end

# cats = DB.from(:cats)
# cats.insert(name: "Scratch", karma: 89, vip: true)
# cats.insert(name: "Meow", karma: 105, vip: false)
# cats.insert(name: 'Felix', karma: 10, vip: false)

class Cat < Sequel::Model
  @cats   = self.from(:cats)
  @params = %w(name karma vip)
  @id = ['id']

  def self.get_cats
    resty @cats.sql
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
  # handler utility methods
  def self.resty(query)
    query.tr(%q{"'}, '')
  end

  def self.hash_params(params)
    hashed_params = []
    params.each { |param| hashed_params << [param.to_sym, "$escaped_#{param.to_s}"] }
    hashed_params.to_h
  end
end
