require 'sequel'
require './config/database.rb'

begin
  cats = DB.from(:cats)
  cats.insert(name: "Scratch", karma: 89,  vip: true)
  cats.insert(name: "Meow",    karma: 105, vip: false)
  cats.insert(name: 'Felix',   karma: 10,  vip: false)

  dogs = DB.from(:dogs)
  dogs.insert(name: "Jessie",   paws: 4,  vip: true)
  dogs.insert(name: "Ivan",     paws: 4,  vip: false)
  dogs.insert(name: 'Snickers', paws: 4,  vip: false)
  dogs.insert(name: 'George',   paws: 3,  vip: true)

rescue Sequel::Error => e
  puts "<= #{e}"
end
