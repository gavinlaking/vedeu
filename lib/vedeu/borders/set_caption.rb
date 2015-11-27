module Vedeu

  module Borders

    # @api private
    #
    class SetCaption

      include Vedeu::Common

      # @param name [String|Symbol]
      # @param caption [String]
      # @return [Vedeu::Borders::Border]
      def self.update(name, caption)
        new(name, caption).update
      end

      # @param name [String|Symbol]
      # @param caption [String]
      # @return [Vedeu::Borders::SetCaption]
      def initialize(name, caption)
        @name    = name
        @caption = caption
      end

      # @return [Vedeu::Borders::Border]
      def update
        border.caption = caption
        border.store { Vedeu.trigger(:_refresh_border_, name) }
        border
      end

      protected

      # @!attribute [r] name
      # @return [String|Symbol] The name of the border.
      attr_reader :name

      private

      # @return [Vedeu::Borders::Border]
      def border
        @_border ||= Vedeu.borders.by_name(name)
      end

      # @return [String] The new caption.
      def caption
        if present?(@caption)
          @caption

        else
          ''

        end
      end

    end # SetCaption

  end # Borders

end # Vedeu
