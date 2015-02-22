require 'test_helper'

describe 'Running a distributed app' do

  it 'runs a simple app and exits' do
    skip
    app    = Vedeu::TestApplication.build
    server = Vedeu::Subprocess.execute!(app)

    client = Vedeu::Distributed::Client.connect("druby://localhost:21420")
    client.input('q')
    client.output.must_equal('')
    client.shutdown
  end

end
