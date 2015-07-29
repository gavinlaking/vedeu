module Vedeu

  module Templating

    # Extend Template to provide client application view specific parsing.
    #
    class ViewTemplate < Template

      include Vedeu::Common
      include Vedeu::Templating::Helpers

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
                             Vedeu::Stream.new(colour: default_colour,
                                               style:  default_style,
                                               value:  stream)

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

      # @return [Vedeu::Colour|Hash<Symbol => Symbol>]
      def default_colour
        if interface?
          interface.colour

        else
          {
            background: :default,
            foreground: :default,
          }

        end
      end

      # @return [Symbol]
      def default_style
        if interface?
          interface.style

        else
          :normal

        end
      end

      # @return [Vedeu::Interface]
      def interface
        Vedeu.interfaces.by_name(options[:name]) if options[:name]
      end
      alias_method :interface?, :interface

      # @param line [String]
      # @return [Array<String>]
      def streams_for(line)
        line.split(/({{\s*[^}]+\s*}})/)
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
