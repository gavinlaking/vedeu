# frozen_string_literal: true

module Vedeu

  module Views

    # Provides the default attributes for variaus Vedeu::Views models.
    #
    # @api private
    #
    module DefaultAttributes

      include Vedeu::Repositories::Defaults

      # @!attribute [r] align
      # @return [Vedeu::Coercers::Alignment]
      attr_reader :align

      # @!attribute [r] pad
      # @return [String]
      attr_reader :pad

      # @!attribute [r] truncate
      # @return [Boolean]
      attr_reader :truncate
      alias truncate? truncate

      # @!attribute [r] width
      # @return [Integer|NilClass]
      attr_reader :width

      # @!attribute [r] wordwrap
      # @return [Boolean]
      attr_reader :wordwrap
      alias wordwrap? wordwrap

      # @return [Hash<Symbol => void>]
      def attributes
        {
          align:    align,
          client:   client,
          colour:   colour,
          name:     name,
          pad:      pad,
          parent:   parent,
          style:    style,
          truncate: truncate,
          width:    width,
          wordwrap: wordwrap,
        }
      end

      private

      # @macro defaults_method
      def defaults
        {
          align:    nil,
          client:   nil,
          colour:   nil,
          name:     nil,
          pad:      ' ',
          parent:   nil,
          style:    nil,
          truncate: false,
          value:    '',
          width:    nil,
          wordwrap: true,
        }
      end

    end # DefaultAttributes

  end # Views

end # Vedeu
