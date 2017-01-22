# frozen_string_literal: true

module Vedeu

  module DSL

    # Wrap or prune a text value based on given options when building
    # views.
    #
    # @api private
    #
    class Wordwrap

      include Vedeu::Common

      # @param (see #initialize)
      # @return (see #content)
      def self.for(text, options = {})
        new(text, options).content
      end

      # Returns a new instance of Vedeu::DSL::Wordwrap.
      #
      # @param text [String]
      # @param options [Hash]
      # @option options ellipsis [String] See {#ellipsis}.
      # @option options mode [Symbol] See {#mode}.
      # @option options name [String|Symbol] See {#name}.
      # @option options width [Integer] See {#width}.
      # @return [Vedeu::DSL::Wordwrap]
      def initialize(text, options = {})
        @text    = text
        @options = defaults.merge!(options)
      end

      # @return [Vedeu::Views::Lines]
      def content
        case mode
        when :prune then to_line_objects(prune)
        when :wrap  then to_line_objects(wrap)
        else
          to_line_objects(split_lines)
        end
      end

      # @return [Array<String>|String]
      def prune
        return text if text.size <= pruned_width

        if split_lines.size > 1
          split_lines.reduce([]) { |a, e| a << ellipsis_string(e) }

        else
          ellipsis_string(text)

        end
      end

      # @return [String]
      def wrap
        processed = []
        split_lines.map do |unprocessed|
          line_length = 0
          reformatted = []

          unprocessed.split(/\s/).map do |word|
            word_length = word.length + 1

            if (line_length += word_length) >= width
              line_length = word_length
              processed << reformatted
              reformatted = []
            end

            reformatted << word
          end

          processed << reformatted
        end

        processed.reduce([]) { |a, e| a << e.join(' ') }
      end

      protected

      # @!attribute [r] text
      # @return [String]
      attr_reader :text

      # @!attribute [r] options
      # @return [Hash]
      attr_reader :options

      private

      # @param text_as_lines [Array<String>]
      # @return [Vedeu::Views::Lines]
      def to_line_objects(text_as_lines)
        line_objects = Array(text_as_lines).map do |text_line|
          stream        = Vedeu::Views::Stream.new(value: text_line)
          line          = Vedeu::Views::Line.new
          stream.parent = line
          line.add(stream)
          line
        end
        Vedeu::Views::Lines.new(line_objects)
      end

      # Returns the text as an array of lines, split on '\n'.
      #
      # @return [Array<String>]
      def split_lines
        text.split(/\n/)
      end

      # @param string [String]
      # @return [String]
      def ellipsis_string(string)
        return prune_string(string) if string.size < ellipsis.size

        "#{prune_string(string)}#{ellipsis}"
      end

      # Returns the string pruned.
      #
      # @param string [String]
      # @return [String]
      def prune_string(string)
        string.chomp.slice(0..pruned_width)
      end

      # Returns the width of the string minus the ellipsis.
      #
      # @return [Integer]
      def pruned_width
        width - ellipsis.size
      end

      # For when using mode `:prune`, by default, provides '...'.
      #
      # @return [String]
      def ellipsis
        options[:ellipsis]
      end

      # @return [Vedeu::Geometries::Geometry]
      def geometry
        Vedeu.geometry.by_name(name)
      end

      # Returns the word wrapping mode. One of :default, :prune or
      #   :wrap;
      #
      #     :default = Renders the content as is.
      #     :prune   = Discards the remainder of the content line
      #                after width.
      #     :wrap    = Forces the content on to a new line after
      #                width.
      #
      # @return [Symbol]
      def mode
        options[:mode]
      end

      # Returns the value of the :name option. When given, and a
      # geometry is registered with this name, the width of the
      # geometry is used if the :width option was not given.
      #
      # @macro return_name
      def name
        options[:name]
      end

      # Returns a boolean indicating the :name option was given and
      # a geometry is registered with that name.
      #
      # @return [Boolean]
      def registered?
        present?(name) && Vedeu.geometries.registered?(name)
      end

      # Returns the width to prune or wrap to.
      #
      # @macro raise_missing_required
      # @return [Integer]
      def width
        return options[:width] if present?(options[:width])
        return geometry.width if registered?

        raise Vedeu::Error::MissingRequired,
              'The text provided cannot be wrapped or pruned because a ' \
              ':width option was not given, or a :name option was either not ' \
              'given or there is no geometry registered with that name.'
      end

      # @macro defaults_method
      def defaults
        {
          ellipsis: '...',
          mode:     :default,
          name:     nil,
          width:    nil,
        }
      end

    end # Wordwrap

  end # DSL

end # Vedeu
