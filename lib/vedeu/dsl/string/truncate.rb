module Vedeu

  module DSL

    class Truncate

      include Vedeu::Common

      # @param value [String]
      # @param options [Hash]
      # @option options name [String|Symbol]
      # @option options truncate [Boolean]
      # @option options width [Fixnum]
      # @return [Vedeu::DSL::Truncate]
      def initialize(value = '', options = {})
        @value   = value || ''
        @options = defaults.merge!(options)
      end

      # @return [String]
      def text
        if truncate?
          truncate

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

      # @return [Hash]
      def defaults
        {
          name:     nil,
          truncate: false,
          width:    nil,
        }
      end

      # @return [Boolean]
      def truncate?
        options[:truncate] == true && value.size > width
      end

      # @return [String]
      def truncate
        value.slice(0, width)
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

        end
      end

    end # Truncate

  end # DSL

end # Vedeu
