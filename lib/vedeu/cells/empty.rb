module Vedeu

  module Cells

    class Empty

      include Comparable
      include Vedeu::Common
      include Vedeu::Presentation
      include Vedeu::Repositories::Defaults

      # @!attribute [r] name
      # @return [String|Symbol] The name of the interface/view this
      #   cell belongs to.
      attr_reader :name

      # @!attribute [r] value
      # @return [String]
      attr_reader :value

      # @return [Boolean]
      def cell?
        true
      end

      # An object is equal when its values are the same.
      #
      # @param other [void]
      # @return [Boolean]
      def eql?(other)
        self.class == other.class    &&
          position == other.position &&
          value    == other.value    &&
          colour   == other.colour
      end
      alias_method :==, :eql?

      private

      # @return [Hash<Symbol => Hash<void>|NilClass|String>]
      def defaults
        {
          colour:   {},
          name:     '',
          position: nil,
          style:    '',
          value:    '',
        }
      end

      # @return [Vedeu::Interfaces::Interface]
      def interface
        @interface ||= Vedeu.interfaces.by_name(name)
      end

    end # Empty

  end # Cells

end # Vedeu
