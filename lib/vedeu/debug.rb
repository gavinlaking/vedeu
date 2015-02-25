require 'ruby-prof'

module Vedeu

  # Helps to debug a running application by providing a stack trace of its
  # execution upon exiting.
  #
  # @param filename [String]
  # @param block [Proc]
  def self.debug(filename = 'profile.html', &block)
    RubyProf.start

    yield

    result = RubyProf.stop
    result.eliminate_methods!([/^Array/, /^Hash/])

    File.open('/tmp/' + filename, 'w') do |file|
      RubyProf::CallStackPrinter.new(result).print(file)
    end
  end

end # Vedeu
