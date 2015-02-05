require 'vedeu/dsl/shared/all'
require 'vedeu/support/common'

module Vedeu

  module DSL

    # Provides methods to be used to define views.
    #
    # @api public
    class Stream

      include Vedeu::DSL::Alignment
      include Vedeu::Common
      include DSL::Colour
      include DSL::Style

      # Returns an instance of DSL::Stream.
      #
      # @param model [Stream]
      def initialize(model, client_binding = nil)
        @model = model
        @client_binding = client_binding
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
                   'Vedeu::DSL::Alignment#align',
                   '0.3.0',
                   '/Vedeu/DSL/Alignment#align-instance_method')
      end
      # :nocov:

      private

      attr_reader :model

      # @param method [Symbol] The name of the method sought.
      # @param args [Array] The arguments which the method was to be invoked
      #   with.
      # @param block [Proc] The optional block provided to the method.
      # @return []
      def method_missing(method, *args, &block)
        Vedeu.log("!!!method_missing '#{method}' (args: #{args.inspect})")

        @client_binding.send(method, *args, &block) if @client_binding
      end

    end # Stream

  end # DSL

end # Vedeu
