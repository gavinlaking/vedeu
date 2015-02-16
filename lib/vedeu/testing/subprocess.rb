require 'pty'
require 'tempfile'

require_relative 'test_application'

app_config = TestApplication.build

file = Tempfile.new('foo')

begin
  file.write(app_config)
  file.close

  # argv   = []
  # fd0    = nil # File.open("/dev/tty", "r")              # stdin
  # fd1    = nil # File.open("/dev/tty", "w")              # stdout
  # fd2    = nil # File.open("/tmp/vedeu_error.log", "w+") # stderr
  # kernel = nil # Kernel

  # app_exec = "VedeuTestApplication.start(#{argv}, #{fd0}, #{fd1}, #{fd2}, #{kernel})"
  # app_exec = ""

  # PTY.spawn("ruby #{file.path} -e '#{app_exec}'") do |output, input, pid|
  PTY.spawn("ruby #{file.path}") do |output, input, pid|
    sleep 2
    # buffer = ""
    # output.readpartial(1024, buffer) until buffer =~ /DONE/
    # buffer.split("\n").each do |line|
    #   puts "[parent] output: #{line}"
    # end
    input.write("q\n")
  end
  puts "---"
ensure
  file.close
  file.unlink
end
