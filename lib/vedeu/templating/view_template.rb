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

            line_object << if stream =~ /({{)|(}})/
                             Vedeu::Templating::Decoder.process(stream)

                           else
                             Vedeu::Stream.new(value: stream)

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

      # @param line [String]
      # @return [Array<String>]
      def streams_for(line)
        line.split(/({{.*}})/)
      end

      # @return [Array<String>]
      def lines
        content.lines.map(&:chomp)
      end

      # @return [String]
      def content
        ERB.new(load, nil, '-').result(binding)
      end

    end # ViewTemplate

  end # Templating

end # Vedeu
