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
          message = ::Pry::ColorPrinter.pp(obj, ''.dup)

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
      # @macro param_block
      # @macro raise_requires_block
      # @return [void]
      # @yieldreturn [void] The section of the application to profile.
      def profile(filename = Dir.tmpdir + '/vedeu_profile', &block)
        Vedeu.requires_gem!('ruby-prof')

        raise Vedeu::Error::RequiresBlock unless block_given?

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
        result.eliminate_methods!(ignore_classes)

        File.open(filename, 'w') do |file|
          # - Creates a HTML visualization of the Ruby stack
          ::RubyProf::CallStackPrinter.new(result).print(file)

          # Used with KCachegrind to analyse performance.
          # ::RubyProf::CallTreePrinter.new(result).print(file)

          # Creates a flat report in text format
          # ::RubyProf::FlatPrinter.new(result).print(file)

          # - same as above but more verbose
          # ::RubyProf::FlatPrinterWithLineNumbers.new(result).print(file)

          # - Creates a call graph report in text format
          # ::RubyProf::GraphPrinter.new(result).print(file)

          # - Creates a call graph report in HTML (separate files per
          #   thread)
          # ::RubyProf::GraphHtmlPrinter.new(result).print(file)

          # - Creates a call graph report in GraphViz's DOT format
          #   which can be converted to an image
          # ::RubyProf::DotPrinter.new(result).print(file)

          # - Creates a call tree report compatible with KCachegrind.
          # ::RubyProf::CallTreePrinter.new(result).print(file)

          # - Uses the other printers to create several reports in one
          #   profiling run
          # ::RubyProf::MultiPrinter.new(result).print(file)
        end

        work
      rescue NameError
        yield
      end

      private

      # @return [Array]
      def ignore_classes
        [
          /^Array/,
          /^Hash/,
          /^String/,
          /^Fixnum/,
        ]
      end

      # :nocov:

    end # Debug

  end # Logging

  # {include:file:docs/dsl/by_method/profile.md}
  # @api public
  # @!method profile
  # @return [Vedeu::Logging::Debug]
  def_delegators Vedeu::Logging::Debug,
                 :profile

  # {include:file:docs/dsl/by_method/debug.md}
  # @api public
  # @!method debug
  # @return [void]
  def_delegators Vedeu::Logging::Debug,
                 :debug

end # Vedeu
