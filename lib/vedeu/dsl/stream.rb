require 'vedeu/dsl/colour'
require 'vedeu/dsl/style'
require 'vedeu/support/alignment'
require 'vedeu/support/common'

module Vedeu

  module DSL

    # Provides methods to be used to define views.
    #
    # @api public
    class Stream

      include Vedeu::Alignment
      include Vedeu::Common
      include DSL::Colour
      include DSL::Style

      # Returns an instance of DSL::Stream.
      #
      # @param model [Stream]
      def initialize(model)
        @model = model
      end

      # Add textual data to the stream via this method.
      #
      # @note Calls `to_s` on the 'value' param; meaning any object which
      #   responds to `to_s` can be provided.
      #
      # @param value [String|undefined] The text to be added to this Stream.
      # @return [String] The param 'value' as a String.
      def stream(value = '')
        model.value << value.to_s
      end
      alias_method :text, :stream

      # @deprecated
      # :nocov:
      def width(value)
        deprecated('Vedeu::API::Stream#width',
                   'Vedeu::Alignment#align',
                   '0.3.0',
                   '/Vedeu/Alignment#align-instance_method')
      end
      # :nocov:

      private

      attr_reader :model

    end # Stream

  end # DSL

end # Vedeu
