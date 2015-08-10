module Vedeu

  module Templating

    # Extend Template to provide client application view specific parsing.
    #
    class ViewTemplate < Template

      include Vedeu::Common
      include Vedeu::Templating::Helpers

      # @return [Vedeu::Views::Lines]
      def parse
        lines_collection = Vedeu::Views::Lines.new

        lines.each do |line|
          line_object = Vedeu::Views::Line.new

          streams_for(line).each do |stream|
            next unless present?(stream)

            line_object << if stream =~ /({{)|(}})/
                             Vedeu::Templating::Decoder.process(stream)

                           else
                             Vedeu::Views::Stream.new(colour: default_colour,
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

      # Return the interface colours if a name option is set, otherwise use the
      # default colours.
      #
      # @return [Vedeu::Colour|Hash<Symbol => Symbol>]
      def default_colour
        if options[:name]
          interface.colour

        else
          {
            background: :default,
            foreground: :default,
          }

        end
      end

      # Return the interface style(s) if a name option is set, otherwise use the
      # default style.
      #
      # @return [Symbol]
      def default_style
        if options[:name]
          interface.style

        else
          :normal

        end
      end

      # Fetch the interface by name.
      #
      # @return [Vedeu::Interface]
      def interface
        Vedeu.interfaces.by_name(options[:name])
      end
      alias_method :interface?, :interface

      # Returns the stream directives for the line.
      #
      # @param line [String]
      # @return [Array<String>]
      def streams_for(line)
        line.split(/({{\s*[^}]+\s*}})/)
      end

      # Convert the content into an array of strings without the line ending
      # character.
      #
      # @return [Array<String>]
      def lines
        content.lines.map(&:chomp)
      end

      # Return a string representing the template processed with ERB.
      #
      # @return [String]
      def content
        ERB.new(load, nil, '-').result(binding)
      end

    end # ViewTemplate

  end # Templating

end # Vedeu
