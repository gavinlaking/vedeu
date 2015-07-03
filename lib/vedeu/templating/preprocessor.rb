module Vedeu

  module Templating

    # preprocess
    #   takes a line at a time
    #   splits line into component parts e.g. text1, ruby, text1
    #     takes text1, adds to JSON stream
    #     processes ruby, adding to a new JSON stream
    #     takes text2, adds to a JSON stream
    #
    # process
    #   converts JSON streams into line/stream objects with correct attributes
    #
    # Pre-processes a template, to convert all lines and lines with directives
    # into Vedeu::Streams.
    #
    # @api private
    class Preprocessor

      # @param lines [Array<String>]
      # @return [Array<Vedeu::Stream>]
      def self.process(lines)
        new(lines).process
      end

      # Returns a new instance of Vedeu::Templating::Preprocessor.
      #
      # @param lines [Array<String>]
      # @return [Vedeu::Templating::Preprocessor]
      def initialize(lines)
        @lines = lines
      end

      # @return [Array<Vedeu::Stream>]
      def process
        lines.each_with_object([]) do |line, acc|
          if line =~ markers?
            code = line.gsub(markers, '').chomp

            acc << Directive.process(code)

          else
            acc << Vedeu::Stream.new(value: line.chomp)

          end
          acc
        end
      end

      protected

      # @!attribute [r] lines
      # @return [Array<String>]
      attr_reader :lines

      private

      # Return a pattern to remove directive markers and spaces.
      #
      # @example
      #   line containing {{ or }}
      #
      # @return [Regexp]
      def markers
        /({{\s*|\s*}})/
      end

      # @example
      #   line contains {{ or }}
      #
      # @return [Regexp]
      def markers?
        /^\s*({{)(.*?)(}})$/
      end

    end # Preprocessor

  end # Templating

end # Vedeu
