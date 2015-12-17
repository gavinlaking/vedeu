module Vedeu

  module Views

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

      # @!attribute [r] width
      # @return [Fixnum|NilClass]
      attr_reader :width

      # @!attribute [r] wordwrap
      # @return [Boolean]
      attr_reader :wordwrap

      # @return [Hash<Symbol => void>]
      def attributes
        {
          align:    align,
          # client:   client,
          # colour:   colour,
          # name:     name,
          pad:      pad,
          # parent:   parent,
          # style:    style,
          truncate: truncate,
          # value:    value,
          width:    width,
          wordwrap: wordwrap,
        }
      end

      private

      # The default values for a new instance of this class.
      #
      # @return [Hash<Symbol => Array<void>|NilClass>]
      def defaults
        {
          align:    Vedeu::Coercers::Alignment.new,
          client:   nil,
          colour:   nil,
          name:     nil,
          pad:      ' ',
          parent:   nil,
          style:    nil,
          truncate: false,
          value:    '',
          width:    nil,
          wordwrap: false,
        }
      end

    end # DefaultAttributes

  end # Views

end # Vedeu