# frozen_string_literal: true

module Vedeu

  module Logging

    # Provides a stack trace of a running client application upon exit
    # in a file for further analysis.
    #
    module Debug

      extend self

      # @param binding [Binding]
      # @param obj [Object]
      # @return [void]
      def debug(binding = nil, obj = nil)
        Vedeu.requires_gem!('pry')

        if obj
          message = ::Pry::ColorPrinter.pp(obj, '')

          Vedeu.log(type: :debug, message: message)

        elsif binding
          Vedeu::Terminal.cooked_mode!
          Vedeu::Terminal.open do
            Vedeu::Terminal.debugging!

            binding.pry
          end
          Vedeu::Terminal.raw_mode!
        end
      end

      # :nocov:
      # {include:file:docs/dsl/by_method/profile.md}
      # @param filename [String] Optional, and defaults to being
      #   written to the /tmp directory.
      # @param block [Proc]
      # @macro raise_requires_block
      # @return [void]
      # @yieldreturn [void] The section of the application to profile.
      def profile(filename = '/tmp/profile.html', &block)
        fail Vedeu::Error::RequiresBlock unless block_given?

        Vedeu.requires_gem!('ruby-prof')

        # ::RubyProf.measure_mode = ::RubyProf::WALL_TIME
        # ::RubyProf.measure_mode = ::RubyProf::PROCESS_TIME
        ::RubyProf.measure_mode = ::RubyProf::CPU_TIME
        # ::RubyProf.measure_mode = ::RubyProf::ALLOCATIONS
        # ::RubyProf.measure_mode = ::RubyProf::MEMORY
        # ::RubyProf.measure_mode = ::RubyProf::GC_TIME
        # ::RubyProf.measure_mode = ::RubyProf::GC_RUNS

        ::RubyProf.start

        work = yield

        result = ::RubyProf.stop
        result.eliminate_methods!([
          /^Array/,
          /^Hash/,
          /^String/,
          /^Fixnum/,
        ])

        File.open(filename, 'w') do |file|
          # - Creates a HTML visualization of the Ruby stack
          ::RubyProf::CallStackPrinter.new(result).print(file)

          # Used with QTCacheGrind to analyse performance.
          # ::RubyProf::CallTreePrinter.new(result).print(file)

          # Creates a flat report in text format
          # ::RubyProf::FlatPrinter

          # - same as above but more verbose
          # ::RubyProf::FlatPrinterWithLineNumbers

          # - Creates a call graph report in text format
          # ::RubyProf::GraphPrinter

          # - Creates a call graph report in HTML (separate files per
          #   thread)
          # ::RubyProf::GraphHtmlPrinter

          # - Creates a call graph report in GraphViz's DOT format
          #   which can be converted to an image
          # ::RubyProf::DotPrinter

          # - Creates a call tree report compatible with KCachegrind.
          # ::RubyProf::CallTreePrinter

          # - Uses the other printers to create several reports in one
          #   profiling run
          # ::RubyProf::MultiPrinter
        end

        work
      rescue NameError
        yield
      end
      # :nocov:

    end # Debug

  end # Logging

  # {include:file:docs/dsl/by_method/profile.md}
  # @!method profile
  # @return [Vedeu::Logging::Debug]
  def_delegators Vedeu::Logging::Debug,
                 :profile

  # {include:file:docs/dsl/by_method/debug.md}
  # @!method debug
  # @return [void]
  def_delegators Vedeu::Logging::Debug,
                 :debug

end # Vedeu
