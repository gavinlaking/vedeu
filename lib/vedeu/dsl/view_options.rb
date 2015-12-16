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
        @_opts = defaults.merge!(opts || {})
        @opts  = nil
      end

      # @return [Vedeu::Coercers::Alignment]
      def align
        Vedeu::Coercers::Alignment.coerce(_opts[:align])
      end

      def coerce
        @opts ||= options

        self
      end

      # @return [NilClass|Vedeu::Colours::Colour]
      def colour
        return nil unless colour_options?

        Vedeu::Colours::Colour.coerce(_opts)
      end

      # @return [NilClass|String|Symbol]
      def name
        _opts[:name]
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

        _opts[:pad][0]
      end

      # @return [NilClass|Vedeu::Presentation::Style]
      def style
        return nil unless style_options?

        Vedeu::Presentation::Style.coerce(_opts)
      end

      # @return [Boolean]
      def truncate
        truthy?(_opts[:truncate])
      end

      # @return [Fixnum|NilClass]
      def width
        if present?(_opts[:width]) && numeric?(_opts[:width])
          _opts[:width]

        elsif present?(name)
          geometry.bordered_width

        end
      end

      # @return [Boolean]
      def wordwrap
        truthy?(_opts[:wordwrap])
      end

      protected

      # @!attribute [r] opts
      # @return [Hash]
      attr_reader :_opts

      private

      # @return [Array<Symbol>]
      def colour_keys
        [:colour, :background, :foreground]
      end

      # @return [Boolean]
      def colour_options?
        return false unless options?

        (_opts.keys & colour_keys).any? { |opt| present?(_opts[opt]) }
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
        present?(_opts)
      end

      # @return [Boolean]
      def style_options?
        return false unless options?

        _opts.include?(:style) && present?(_opts[:style])
      end

      # @return [Boolean]
      def valid_pad?
        present?(_opts[:pad]) && string?(_opts[:pad])
      end

    end # ViewOptions

  end # DSL

end # Vedeu
