module Vedeu

  module DSL

    # @api private
    #
    class Attributes

      include Vedeu::Common

      # @return [Hash]
      def self.build(context = nil,
                     model   = nil,
                     value   = '',
                     options = {},
                     &block)
        new(context, model, value, options, &block).attributes
      end

      # @return [Vedeu::DSL::Attributes]
      def initialize(context = nil,
                     model   = nil,
                     value   = '',
                     options = {},
                     &block)
        @_context = context
        @_model   = model
        @_value   = value   || ''
        @_options = options || {}
        @_block   = block
      end

      # @return [Hash]
      def attributes
        Vedeu::DSL::ViewOptions.coerce(options).options.merge!(value_attribute)
      end

      protected

      # @!attribute [r] _context
      # @return [NilClass|Vedeu::DSL::Elements]
      attr_reader :_context

      # @!attribute [r] _model
      # @return [NilClass|Vedeu::Views::*]
      attr_reader :_model

      # @!attribute [r] _value
      # @return [NilClass|String]
      attr_reader :_value

      # @!attribute [r] _options
      # @return [Hash]
      attr_reader :_options

      # @!attribute [r] _block
      # @return [NilClass|Proc]
      attr_reader :_block

      private

      # Returns the client object which called the DSL method.
      #
      # @return [Object]
      def client
        if _block
          eval(_context.class.name, _block.binding)

        elsif _model
          _model.client

        end
      end

      # @return [Hash<Symbol => void|String|Symbol]
      def options
        _options.merge!(client: client, name: _model.name)
      end

      # @return [Hash<Symbol => String>]
      def value_attribute
        return {} if _block

        { value: value }
      end

      # @return [String]
      def value
        return _value if present?(_value)

        ''
      end

    end # Attributes

  end # DSL

end # Vedeu
