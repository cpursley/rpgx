require 'sequel'
require './config/database.rb'

cats = DB.from(:cats)
cats.insert(name: "Scratch", karma: 89,  vip: true)
cats.insert(name: "Meow",    karma: 105, vip: false)
cats.insert(name: 'Felix',   karma: 10,  vip: false)
