require 'open3'
require 'tempfile'

require_relative 'test_application'

app = TestApplication.build

file = Tempfile.new('foo')

begin
  file.write(app)
  file.close

  Open3.popen3("ruby #{file.path}") do |stdin, stdout, stderr|
    sleep 2
    stdin.write("q\n")
    stdin.close_write
    stdout.read.split("\n").each do |line|
      puts "[parent] stdout: #{line}"
    end
    stderr.read.split("\n").each do |line|
      puts "[parent] stderr: #{line}"
    end
  end
  puts "---"
ensure
  file.close
  file.unlink
end
