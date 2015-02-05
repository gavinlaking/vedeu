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
      def initialize(model, client = nil)
        @model = model
        @client = client
      end

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

        @client.send(method, *args, &block) if @client
      end

    end # Stream

  end # DSL

end # Vedeu
