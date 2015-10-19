require 'fileutils'
require 'erb'

# class Generate < Thor
class Generate < Thor

  desc "generate", "Generate a migration file."
  def migration(name)
      migration = rand.to_s[2..10] + "_#{name}"
      file_name = migration + ".rb"
      template  = ERB.new(File.read("./migration_template.erb"))
      content   = template.result(binding)
      path      = "#{File.expand_path("../..", Dir.pwd)}\/db/migrations" + "/#{file_name}"
      File.open(path, "w") { |file| file.puts content }
      puts "New migration: #{File.expand_path("../..", Dir.pwd)}\/db/migrations" + "/#{file_name}"
    end
end
