require 'test_helper'

class MyFirstApplication
  include Vedeu

  interface 'hydrogen' do
    x       2
    y       2
    width   50
    height  2
  end

  def self.start
    Vedeu::Launcher.new(['--run-once', '--noninteractive']).execute!
  end
end

describe 'Run the application once, printing a message on the screen and ' \
         'gracefully terminating.' do
  it 'writes a message to the screen' do
    skip
    stdout, stderr = capture_io { MyFirstApplication.start }
    stdout.must_equal('Great success! Now, try something a little harder.')
    stderr.must_equal('')
  end
end
