module Vedeu

  # Provides means to use templates with Vedeu.
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
    class PostProcessor

      # @param content [String]
      # @return [Array<Vedeu::Stream>]
      def self.process(content)
        new(content).process
      end

      # Returns a new instance of Vedeu::Templating::PostProcessor.
      #
      # @param content [String]
      # @return [Vedeu::Templating::PostProcessor]
      def initialize(content)
        @content = content
      end

      # @return [Vedeu::Streams]
      def process
        lines.each_with_object(Vedeu::Streams.new) do |line, acc|
          if line =~ markers?
            acc << Vedeu::Templating::Decoder.process(unmark(line))

          else
            acc << Vedeu::Stream.new(value: line.chomp)

          end
          acc
        end
      end

      protected

      # @!attribute [r] content
      # @return [String]
      attr_reader :content

      private

      # @return [Array<String>]
      def lines
        content.lines
      end

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

      # @param line [String]
      # @return [String]
      def unmark(line)
        line.gsub(markers, '').chomp
      end

    end # PostProcessor

  end # Templating

end # Vedeu
