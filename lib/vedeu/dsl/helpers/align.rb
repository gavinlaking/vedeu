# frozen_string_literal: true

module Vedeu

  module DSL

    # Aligns a text value based on given options when building views.
    #
    # @api private
    #
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
      # @option options width [Integer]
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
      alias center centre

      # @macro defaults_method
      def defaults
        {
          align: :left,
          name:  nil,
          pad:   ' ',
          width: nil,
        }
      end

      # @macro geometry_by_name
      def geometry
        @_geometry ||= Vedeu.geometries.by_name(options[:name])
      end

      # The value padded to width, left justified. See {#width}.
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

      # Return the width given in the options. If no :width option was
      # set, but a :name option was set, then we can use the width of
      # the interface to determine the correct width to use. There is
      # a caveat in this; if the :align option was set to :left, but
      # no :width provided, then we don't want to use the interface's
      # width. The reason being, is that there may be another stream
      # in this line which will not appear by default as it will be
      # push right out of the visible area.
      #
      # Return the width of the interface when a name is given,
      # otherwise use the given width.
      #
      # @return [Integer]
      def width
        if present?(options[:width])
          options[:width]

        elsif present?(options[:name])
          if left_aligned?
            value.size

          else
            geometry.bordered_width

          end

        else
          value.size

        end
      end

    end # Align

  end # DSL

end # Vedeu
