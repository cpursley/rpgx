require 'fileutils'
require 'erb'

# see https://github.com/bellycard/napa/commit/122ef4d489871b73e7f0711a41c9781283e03619

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
