module Vedeu

  # :nocov:
  # Helps to debug a running application by providing a stack trace of its
  # execution upon exiting.
  #
  # @param filename [String]
  # @param block [Proc]
  def self.debug(filename = 'profile.html', &block)
    require 'ruby-prof'

    RubyProf.start

    yield

    result = RubyProf.stop
    result.eliminate_methods!([/^Array/, /^Hash/])

    File.open('/tmp/' + filename, 'w') do |file|
      RubyProf::CallStackPrinter.new(result).print(file)

      # Used with QTCacheGrind to analyse performance.
      # RubyProf::CallTreePrinter.new(result).print(file)
    end
  end
  # :nocov:

end # Vedeu
