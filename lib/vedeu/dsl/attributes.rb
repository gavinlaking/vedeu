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
          if eval('client', _block.binding).nil?
            eval(_context.class.name, _block.binding)

          else
            eval('client', _block.binding)

          end
        elsif model?
          _model.client

        end
      end

      # @return [Hash]
      def model_colour
        return {} unless model?

        if _model.colour
          _model.colour.attributes

        else
          {}

        end
      end

      # @return [Hash]
      def client_option
        {
          client: client
        }
      end

      # @return [Hash]
      def background_option
        if _options.key?(:background) &&
           valid_colour_option?(_options[:background])
          {
            background: _options[:background]
          }

        elsif _options.key?(:colour) &&
              hash?(_options[:colour]) &&
              _options[:colour].key?(:background) &&
              valid_colour_option?(_options[:colour][:background])
          {
            background: _options[:colour][:background]
          }

        else
          {}

        end
      end

      # @return [Hash]
      def colour_options
        {}.merge!(model_colour)
          .merge!(background_option)
          .merge!(foreground_option)
      end

      # @return [Hash]
      def foreground_option
        if _options.key?(:foreground) &&
           valid_colour_option?(_options[:foreground])
          {
            foreground: _options[:foreground]
          }

        elsif _options.key?(:colour) &&
              hash?(_options[:colour]) &&
              _options[:colour].key?(:foreground) &&
              valid_colour_option?(_options[:colour][:foreground])
          {
            foreground: _options[:colour][:foreground]
          }

        else
          {}

        end
      end

      # @return [Boolean]
      def model?
        present?(_model)
      end

      # @return [Hash]
      def name_option
        return {} unless model?

        {
          name: _model.name
        }
      end

      # @return [Hash<Symbol => void|String|Symbol]
      def options
        _options.merge!(client_option).merge!(name_option).merge!(colour_options)
      end

      # @return [Boolean]
      def valid_colour_option?(colour)
        Vedeu::Colours::Validator.valid?(colour)
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
