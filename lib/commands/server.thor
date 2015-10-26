class Server < Thor
  PID_PATH   = "/usr/local/var/run/openresty.pid"
  NGINX_PATH = "#{File.expand_path("..", Dir.pwd)}/nginx"

  desc "server", "Start the openresty server."
  def start
    conf_path = NGINX_PATH + "/conf/nginx.conf"
    if File.exist?(conf_path)
      begin
        unless File.exist?("#{PID_PATH}")
          system "openresty -p #{NGINX_PATH} -c conf/nginx.conf"
          if $?.exitstatus == 0
            puts "<= The openresty server has started"
          end
        else
          puts "<= The openresty server is already running"
        end
      rescue Thor::UndefinedCommandError => e
        puts "<= #{e}"
      end
    else
      puts "<= Routes not built. Please run 'rake build:routes' first"
    end
  end

  desc "server", "Stop the openresty server."
  def stop
    begin
      if File.exist?("#{PID_PATH}")
        system "openresty -s stop"
        if $?.exitstatus == 0
          puts "<= The openresty server has stopped"
        end
      else
        puts "<= The openresty server is already stopped"
      end
    rescue Thor::UndefinedCommandError => e
      puts "<= #{e}"
    end
  end
end
