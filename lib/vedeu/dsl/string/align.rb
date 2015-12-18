module Vedeu

  module DSL

    class Align

      extend Forwardable
      include Vedeu::Common

      def_delegators :alignment,
                     :centre_aligned?,
                     :left_aligned?,
                     :right_aligned?,
                     :unaligned?

      # @param value [String]
      # @param options [Hash]
      # @option options align [Symbol]
      # @option options name [String|Symbol]
      # @option options pad [String]
      # @option options width [Fixnum]
      # @return [Vedeu::DSL::Align]
      def initialize(value = '', options = {})
        @value   = value || ''
        @options = defaults.merge!(options)
      end

      # @return [String]
      def text
        if unaligned?
          value

        elsif left_aligned?
          left

        elsif centre_aligned?
          centre

        elsif right_aligned?
          right

        else
          value

        end
      end

      protected

      # @!attribute [r] options
      # @return [Hash]
      attr_reader :options

      # @!attribute [r] value
      # @return [String]
      attr_reader :value

      private

      # @return [Vedeu::Coercers::Alignment]
      def alignment
        @_alignment ||= Vedeu::Coercers::Alignment.coerce(options[:align])
      end

      # The value padded to width, centralized.
      #
      # @return [String]
      def centre
        value.center(width, options[:pad])
      end
      alias_method :center, :centre

      # @return [Hash]
      def defaults
        {
          align: :left,
          name:  nil,
          pad:   ' ',
          width: nil,
        }
      end

      # @return [NilClass|Vedeu::Geometries::Geometry]
      def geometry
        @_geometry ||= Vedeu.geometries.by_name(options[:name])
      end

      # The value padded to width, left justified.
      #
      # @return [String]
      def left
        value.ljust(width, options[:pad])
      end

      # The value padded to width, right justified.
      #
      # @return [String]
      def right
        value.rjust(width, options[:pad])
      end

      # Return the width of the interface when a name is given,
      # otherwise use the given width.
      #
      # @return [Fixnum]
      def width
        if present?(options[:width])
          options[:width]

        elsif present?(options[:name])
          geometry.bordered_width

        else
          value.size

        end
      end

    end # Align

  end # DSL

end # Vedeu
