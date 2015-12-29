require 'sequel'
require 'pry'
require 'thor'
require './config/database.rb'

module CLI
  class Commands < Thor
    include Thor::Actions

    # RubyResty Console
    desc "console", "Start the RubyResty console."
    def console
      begin
        DB.pry
      rescue Thor::UndefinedCommandError => e
        say "<= There was an issue starting the RubyResty console: #{e}", :red
      end
    end

    # RubyResty Server
    desc "start", "Start the openresty server."
    def start
      conf_path = nginx_path + "/conf/nginx.conf"
      if File.exist?(conf_path)
        begin
          unless File.exist?(pid_path)
            system "openresty -p #{nginx_path} -c conf/nginx.conf"
            if $?.exitstatus == 0
              say "<= The openresty server has started", :blue
            end
          else
            say "<= The openresty server is already running", :yellow
          end
        rescue Thor::UndefinedCommandError => e
          puts "<= #{e}", :red
        end
      else
        say "<= Routes not built. Please run 'rake routes:build' first", :red
      end
    end

    desc "stop", "Stop the openresty server."
    def stop
      begin
        if File.exist?(pid_path)
          system "openresty -s stop"
          if $?.exitstatus == 0
            say "<= The openresty server has stopped", :blue
          end
        else
          say "<= The openresty server is already stopped", :yellow
        end
      rescue Thor::UndefinedCommandError => e
        puts "<= #{e}", :red
      end
    end

    # Generate Migration
    desc "migration NAME", "Generate a migration file."
    def migration(name)
      file_name = "db/migrations/#{version}_#{name}"
      self.class.source_root(File.dirname(__FILE__))
      say '<= Generating migration...', :blue
      template(
        'templates/migration_template.tt',
        "#{File.expand_path("./.", Dir.pwd)}" + "/#{file_name}.rb"
      )
    end

    no_commands do
      def pid_path
        "/usr/local/var/run/openresty.pid"
      end

      def nginx_path
        "lib/nginx"
      end

      def version
        Time.now.utc.to_s.gsub(':','').gsub('-','').gsub('UTC','').gsub(' ','')
      end
    end
  end
end
