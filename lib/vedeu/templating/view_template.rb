# frozen_string_literal: true

module Vedeu

  module Templating

    # Extend Template to provide client application view specific
    # parsing.
    #
    class ViewTemplate < Vedeu::Templating::Template

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

      # Return the interface colours if a name option is set,
      # otherwise use the default colours.
      #
      # @return [Vedeu::Colours::Colour|Hash<Symbol => Symbol>]
      def default_colour
        return interface.colour if options[:name]

        {
          background: :default,
          foreground: :default,
        }
      end

      # Return the interface style(s) if a name option is set,
      # otherwise use the default style.
      #
      # @return [Symbol]
      def default_style
        return interface.style if options[:name]

        :normal
      end

      # Returns the interface by name.
      #
      # @return (see Vedeu::Interfaces::Repository#by_name)
      def interface
        Vedeu.interfaces.by_name(name)
      end
      alias_method :interface?, :interface

      # @return [String|Symbol]
      def name
        options[:name]
      end

      # Returns the stream directives for the line.
      #
      # @param line [String]
      # @return [Array<String>]
      def streams_for(line)
        line.split(/({{\s*[^}]+\s*}})/)
      end

      # Convert the content into an array of strings without the line
      # ending character.
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
