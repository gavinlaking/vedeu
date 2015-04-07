module Vedeu

  # :nocov:
  # Helps to debug a running application by providing a stack trace of its
  # execution upon exiting.
  #
  # @param filename [String]
  # @param block [Proc]
  def self.debug(filename = 'profile.html', &block)
    require 'ruby-prof'

    RubyProf.measure_mode = RubyProf::WALL_TIME
    # RubyProf.measure_mode = RubyProf::PROCESS_TIME
    # RubyProf.measure_mode = RubyProf::CPU_TIME
    # RubyProf.measure_mode = RubyProf::ALLOCATIONS
    # RubyProf.measure_mode = RubyProf::MEMORY
    # RubyProf.measure_mode = RubyProf::GC_TIME
    # RubyProf.measure_mode = RubyProf::GC_RUNS

    RubyProf.start

    yield

    result = RubyProf.stop
    result.eliminate_methods!([
      /^Array/,
      /^Hash/,
    ])

    File.open('/tmp/' + filename, 'w') do |file|
      RubyProf::CallStackPrinter.new(result).print(file)

      # Used with QTCacheGrind to analyse performance.
      # RubyProf::CallTreePrinter.new(result).print(file)

      # Creates a flat report in text format
      # RubyProf::FlatPrinter

      # - same as above but more verbose
      # RubyProf::FlatPrinterWithLineNumbers

      # - Creates a call graph report in text format
      # RubyProf::GraphPrinter

      # - Creates a call graph report in HTML (separate files per thread)
      # RubyProf::GraphHtmlPrinter

      # - Creates a call graph report in GraphViz's DOT format which can be
      #   converted to an image
      # RubyProf::DotPrinter

      # - Creates a call tree report compatible with KCachegrind.
      # RubyProf::CallTreePrinter

      # - Creates a HTML visualization of the Ruby stack
      # RubyProf::CallStackPrinter

      # - Uses the other printers to create several reports in one profiling run
      # RubyProf::MultiPrinter
    end
  end
  # :nocov:

end # Vedeu
