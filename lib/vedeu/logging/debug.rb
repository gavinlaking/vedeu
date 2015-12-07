module Vedeu

  module Logging

    # Provides a stack trace of a running client application upon exit
    # in a file for further analysis.
    #
    module Debug

      extend self

      # :nocov:
      # Helps to profile a running application by providing a stack
      # trace of its execution upon exiting.
      #
      # @example
      #   Vedeu.profile('some_file.html') do
      #     # ... code to profile ...
      #   end
      #
      # @param filename [String] Optional, and defaults to being
      #   written to the /tmp directory.
      # @param block [Proc]
      # @return [void]
      # @yieldreturn [void] The section of the application to profile.
      def self.profile(filename = 'profile.html', &block)
        return nil unless block_given?

        require 'ruby-prof'

        # RubyProf.measure_mode = RubyProf::WALL_TIME
        # RubyProf.measure_mode = RubyProf::PROCESS_TIME
        RubyProf.measure_mode = RubyProf::CPU_TIME
        # RubyProf.measure_mode = RubyProf::ALLOCATIONS
        # RubyProf.measure_mode = RubyProf::MEMORY
        # RubyProf.measure_mode = RubyProf::GC_TIME
        # RubyProf.measure_mode = RubyProf::GC_RUNS

        RubyProf.start

        work = yield

        result = RubyProf.stop
        result.eliminate_methods!([
          /^Array/,
          /^Hash/,
          /^String/,
          /^Fixnum/,
        ])

        File.open('/tmp/' + filename, 'w') do |file|
          # - Creates a HTML visualization of the Ruby stack
          RubyProf::CallStackPrinter.new(result).print(file)

          # Used with QTCacheGrind to analyse performance.
          # RubyProf::CallTreePrinter.new(result).print(file)

          # Creates a flat report in text format
          # RubyProf::FlatPrinter

          # - same as above but more verbose
          # RubyProf::FlatPrinterWithLineNumbers

          # - Creates a call graph report in text format
          # RubyProf::GraphPrinter

          # - Creates a call graph report in HTML (separate files per
          #   thread)
          # RubyProf::GraphHtmlPrinter

          # - Creates a call graph report in GraphViz's DOT format
          #   which can be converted to an image
          # RubyProf::DotPrinter

          # - Creates a call tree report compatible with KCachegrind.
          # RubyProf::CallTreePrinter

          # - Uses the other printers to create several reports in one
          #   profiling run
          # RubyProf::MultiPrinter
        end

        work
      end
      # :nocov:

    end # Debug

  end # Logging

  # Allow debugging via the creation of stack traces courtesy of
  # ruby-prof.
  #
  # @example
  #   Vedeu.profile
  #
  # @!method profile
  # @return [Vedeu::Logging::Debug]
  def_delegators Vedeu::Logging::Debug,
                 :profile

end # Vedeu
