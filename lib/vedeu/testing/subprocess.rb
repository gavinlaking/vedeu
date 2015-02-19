require 'pty'

require_relative 'test_application'

app_config = TestApplication.build
timestamp = Time.now.to_i
file = File.new("/tmp/foo_#{timestamp}", "w")
file.write(app_config)
file.close

cmd = "ruby #{file.path}"
begin
  PTY.spawn(cmd) do |stdin, stdout, pid|
    begin
      # Do stuff with the output here. Just printing to show it works
      stdin.each { |line| print line }
    rescue Errno::EIO
      puts "Errno:EIO error, but this probably just means " +
            "that the process has finished giving output"
    end
  end
rescue PTY::ChildExited
  puts "The child process exited!"
ensure
  File.unlink("/tmp/foo_#{timestamp}")
end
