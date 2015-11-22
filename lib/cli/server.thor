class Server < Thor
  include Thor::Actions
  namespace :server

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
      say "<= Routes not built. Please run 'rake build:routes' first", :red
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

  no_commands do
    def pid_path
      "/usr/local/var/run/openresty.pid"
    end

    def nginx_path
      "#{File.expand_path("..", Dir.pwd)}/nginx"
    end
  end
end
