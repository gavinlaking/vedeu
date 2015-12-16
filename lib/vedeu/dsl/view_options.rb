module Vedeu

  module DSL

    class ViewOptions

      include Vedeu::Common

      # @param opts [Hash]
      # @option opts align [Symbol] One of :center, :centre, :left,
      #   :none (default) or :right.
      # @option opts background [String] The background colour.
      # @option opts colour [Hash] The colour.
      # @option colour background [String] The background colour.
      # @option colour foreground [String] The foreground colour.
      # @option opts foreground [String] The foreground colour.
      # @option opts name [NilClass|String|Symbol]
      # @option opts pad [String] The character to use to pad the
      #   value.
      # @option opts style [Array<Symbol>|
      #   Hash<Symbol => Array<Symbol>|Symbol>|Symbol] The style.
      # @option opts truncate [Boolean] Whether the value should be
      #   truncated.
      # @option opts width [Fixnum] The desired width for the value.
      # @option opts wordwrap [Boolean] Whether the value should be
      #   wordwrapped.
      # @return [Vedeu::DSL::ViewOptions]
      def initialize(opts = {})
        @opts = defaults.merge!(opts || {})
      end

      # @return [Vedeu::Coercers::Alignment]
      def align
        Vedeu::Coercers::Alignment.coerce(opts[:align])
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
          align:    align,
          colour:   colour,
          name:     name,
          pad:      pad,
          style:    style,
          truncate: truncate,
          width:    width,
          wordwrap: wordwrap,
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

      # @return [Boolean]
      def truncate
        truthy?(opts[:truncate])
      end

      # @return [Fixnum|NilClass]
      def width
        if present?(opts[:width]) && numeric?(opts[:width])
          opts[:width]

        elsif present?(opts[:name])
          geometry.bordered_width

        end
      end

      # @return [Boolean]
      def wordwrap
        truthy?(opts[:wordwrap])
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
          align:    :none,
          colour:   nil,
          name:     nil,
          pad:      ' ',
          style:    nil,
          truncate: false,
          width:    nil,
          wordwrap: false,
        }
      end

      # @return [NilClass|Vedeu::Geometries::Geometry]
      def geometry
        @_geometry ||= Vedeu.geometries.by_name(name)
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
