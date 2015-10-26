require 'fileutils'
require 'erb'

# how can we alias thor with resty ?? i.e., resty generate:migration cats
# refactor like https://github.com/bellycard/napa/commit/122ef4d489871b73e7f0711a41c9781283e03619

# options ?
#  - create_table, name, attributes
#  - create_view, name, attributes
# perhaps: resty generate:table Cat name:string karma:integer vip:boolean

# class Generate < Thor
class Generate < Thor
  desc "generate", "Generate a migration file."
  def migration(name)
    migration = Time.now.utc.to_s.gsub(':','').gsub('-','').gsub('UTC','').gsub(' ','')
    file_name = migration + "_#{name}.rb"
    template  = ERB.new(File.read("./migration_template.erb"))
    content   = template.result(binding)
    path      = "#{File.expand_path("../..", Dir.pwd)}\/db/migrations" + "/#{file_name}"
    File.open(path, "w") { |file| file.puts content }
    puts "New migration: #{File.expand_path("../..", Dir.pwd)}\/db/migrations" + "/#{file_name}"
  end
end
