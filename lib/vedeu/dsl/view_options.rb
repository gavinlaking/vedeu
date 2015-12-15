module Vedeu

  module DSL

    class ViewOptions

      include Vedeu::Common

      # @param opts [Hash]
      # @option opts align [Symbol] One of :center, :centre, :left,
      #   :none (default) or :right.
      # @option opts background [String]
      # @option opts colour [Hash]
      # @option colour background [String]
      # @option colour foreground [String]
      # @option opts foreground [String]
      # @option opts name [NilClass|String|Symbol]
      # @option opts pad [String]
      # @option opts style [Array<Symbol>|
      #   Hash<Symbol => Array<Symbol>|Symbol>|Symbol]
      # @option opts width [Fixnum]
      # @return [Vedeu::DSL::ViewOptions]
      def initialize(opts = {})
        @opts = defaults.merge!(opts || {})
      end

      # @return [Symbol]
      def align
        Vedeu::Coercers::Alignment.coerce(opts[:align]).align
      end

      # @return [NilClass|Vedeu::Colours::Colour]
      def colour
        return nil unless colour_options?

        Vedeu::Colours::Colour.coerce(opts)
      end

      # @return [NilClass|String|Symbol]
      def name
        opts[:name]
      end

      # @return [Hash]
      def options
        {
          align:  align,
          colour: colour,
          name:   name,
          pad:    pad,
          style:  style,
          width:  width,
        }
      end

      # @return [String]
      def pad
        return defaults[:pad] unless valid_pad?

        opts[:pad][0]
      end

      # @return [NilClass|Vedeu::Presentation::Style]
      def style
        return nil unless style_options?

        Vedeu::Presentation::Style.coerce(opts)
      end

      # @return [Fixnum|NilClass]
      def width
        if present?(opts[:width]) && numeric?(opts[:width])
          opts[:width]

        elsif present?(opts[:name])
          geometry.bordered_width

        end
      end

      protected

      # @!attribute [r] opts
      # @return [Hash]
      attr_reader :opts

      private

      # @return [Array<Symbol>]
      def colour_keys
        [:colour, :background, :foreground]
      end

      # @return [Boolean]
      def colour_options?
        return false unless options?

        (opts.keys & colour_keys).any? { |opt| present?(opts[opt]) }
      end

      # @return [Hash]
      def defaults
        {
          align:  :none,
          colour: nil,
          name:   nil,
          pad:    ' ',
          style:  nil,
          width:  nil,
        }
      end

      # @return [NilClass|Vedeu::Geometries::Geometry]
      def geometry
        Vedeu.geometries.by_name(name)
      end

      # @return [Boolean]
      def options?
        present?(opts)
      end

      # @return [Boolean]
      def style_options?
        return false unless options?

        opts.include?(:style) && present?(opts[:style])
      end

      # @return [Boolean]
      def valid_pad?
        present?(opts[:pad]) && string?(opts[:pad])
      end

    end # ViewOptions

  end # DSL

end # Vedeu
