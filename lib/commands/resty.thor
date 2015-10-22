class Server < Thor
  PID_PATH = "/usr/local/var/run/openresty.pid"

  desc "server", "Start the openresty server."
  def start
    begin
      unless File.exist?("#{PID_PATH}")
        conf_path = "#{File.expand_path("..", Dir.pwd)}/nginx"
        system "openresty -p #{conf_path} -c conf/nginx.conf"
        if $?.exitstatus == 0
          puts "<= The openresty server has started"
        end
      else
        puts "<= The openresty server is already running"
      end
    rescue Thor::UndefinedCommandError => e
      puts "<= #{e}"
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
