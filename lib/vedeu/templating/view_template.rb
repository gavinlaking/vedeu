module Vedeu

  module Templating

    # Extend Template to provide client application view specific parsing.
    #
    class ViewTemplate < Template

      include Vedeu::Common
      include Vedeu::Templating::ViewHelpers

      # @return [Vedeu::Lines]
      def parse
        lines_collection = Vedeu::Lines.new

        lines.each do |line|
          line_object = Vedeu::Line.new

          streams_for(line).each do |stream|
            next unless present?(stream)

            if stream =~ markers
              line_object << Vedeu::Templating::Decoder.process(unmark(stream))

            else
              line_object << Vedeu::Stream.new(value: stream)

            end
          end

          lines_collection << line_object
        end

        lines_collection
      end

      protected

      # @!attribute [r] object
      # @return [Class]
      attr_reader :object

      # @!attribute [r] options
      # @return [Hash]
      attr_reader :options

      private

      # @return [String]
      def content
        ERB.new(load, nil, '-').result(binding)
      end

      # @return [Array<String>]
      def lines
        content.lines.map(&:chomp)
      end

      # @param line [String]
      # @return [Array<String>]
      def streams_for(line)
        line.split(/({{.*}})/)
      end

      # Return a pattern to remove directive markers and spaces.
      #
      # @example
      #   line containing {{ or }}
      #
      # @return [Regexp]
      def markers
        /({{)|(}})/
      end
      alias_method :markers?, :markers

      # Removes the markers and any line returns from the given stream.
      #
      # @param stream [String]
      # @return [String]
      def unmark(stream)
        stream.gsub(markers, '')
      end

    end # ViewTemplate

  end # Templating

end # Vedeu
