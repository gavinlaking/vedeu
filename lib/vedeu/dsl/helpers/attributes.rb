# frozen_string_literal: true

module Vedeu

  module DSL

    # Creates attributes for DSL objects.
    #
    # @api private
    #
    class Attributes

      include Vedeu::Common

      # @param (see #initialize)
      # @return (see #attributes)
      def self.build(context = nil,
                     model   = nil,
                     value   = '',
                     options = {},
                     &block)
        new(context, model, value, options, &block).attributes
      end

      # @param context [NilClass]
      # @param model [NilClass]
      # @param value [NilClass|String]
      # @param options [Hash]
      # @option options align [Symbol] One of :center, :centre, :left,
      #   :none (default) or :right.
      # @option options background [String] The background colour.
      # @option options colour [Hash] The colour.
      # @option colour background [String] The background colour.
      # @option colour foreground [String] The foreground colour.
      # @option options foreground [String] The foreground colour.
      # @option options name [NilClass|String|Symbol]
      # @option options pad [String] The character to use to pad the
      #   value.
      # @option options style [Array<Symbol>|
      #   Hash<Symbol => Array<Symbol>|Symbol>|Symbol] The style.
      # @option options truncate [Boolean] Whether the value should be
      #   truncated.
      # @option options width [Fixnum] The desired width for the
      #   value.
      # @option options wordwrap [Boolean] Whether the value should be
      #   wordwrapped.
      # @macro param_block
      # @return [Vedeu::DSL::Attributes]
      def initialize(context = nil,
                     model   = nil,
                     value   = '',
                     options = {},
                     &block)
        @context = context
        @model   = model
        @value   = value   || ''
        @options = options || {}
        @block   = block
      end

      # @return [Hash]
      def attributes
        {
          align:    align,
          client:   client,
          colour:   colour,
          name:     name,
          pad:      pad,
          style:    style,
          truncate: truncate,
          width:    width,
          wordwrap: wordwrap,
        }.merge!(value)
      end

      protected

      # @!attribute [r] context
      # @return [NilClass|Vedeu::DSL::Elements]
      attr_reader :context

      # @!attribute [r] model
      # @return [NilClass|Vedeu::Views::*]
      attr_reader :model

      # @!attribute [r] block
      # @return [NilClass|Proc]
      attr_reader :block

      private

      # @return [Vedeu::Coercers::Alignment]
      def align
        Vedeu::Coercers::Alignment.coerce(options[:align])
      end

      # Returns the client object which called the DSL method.
      #
      # @return [Object]
      def client
        if block
          if eval('client', block.binding).nil?
            eval(context.class.name, block.binding)

          else
            eval('client', block.binding)

          end
        elsif present?(model)
          model.client

        end
      end

      # @return [Vedeu::Colours::Colour]
      def colour
        Vedeu::Colours::Colour.coerce(new_colour_options)
      end

      # @macro defaults_method
      def defaults
        {
          align:      :none,
          client:     nil,
          colour:     nil,
          name:       nil,
          pad:        ' ',
          style:      nil,
          truncate:   false,
          width:      nil,
          wordwrap:   true,
        }
      end

      # @macro geometry_by_name
      def geometry
        @_geometry ||= Vedeu.geometries.by_name(name)
      end

      # @return [NilClass|String|Symbol]
      def name
        return model.name if present?(model) && present?(model.name)

        nil
      end

      # @return [Hash]
      def options
        defaults.merge!(@options)
      end

      # @return [String]
      def pad
        options[:pad].to_s[0] || ' '
      end

      # @return [NilClass|Vedeu::Presentation::Style]
      def style
        Vedeu::Presentation::Style.coerce(options[:style])
      end

      # @return [Boolean]
      def truncate
        truthy?(options[:truncate])
      end

      # @return [Hash<Symbol => String>]
      def value
        if block
          {}

        elsif absent?(@value)
          {}

        else
          {
            value: @value,
          }

        end
      end

      # @return [Fixnum|NilClass]
      def width
        if numeric?(options[:width])
          options[:width]

        elsif view_model? && name
          geometry.bordered_width

        end
      end

      # @return [Boolean]
      def wordwrap
        truthy?(options[:wordwrap])
      end

      # @return [Array<Symbol>]
      def colour_attributes
        [:background, :colour, :foreground]
      end

      # @return [Hash]
      def colour_options
        options.select { |k, _| colour_attributes.include?(k) }
      end

      # @return [Hash]
      def coerce_colour_options
        Vedeu::Coercers::ColourAttributes.coerce(colour_options)
      end

      # @return [Hash]
      def model_colour
        return {} unless present?(model) && model.colour

        model.colour.attributes
      end

      # @return [Hash]
      def new_colour_options
        model_colour.merge(coerce_colour_options)
      end

    end # Attributes

  end # DSL

end # Vedeu
