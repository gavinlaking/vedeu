module Vedeu

  module Borders

    # @api private
    #
    class SetTitle

      include Vedeu::Common

      # @param name [String|Symbol]
      # @param title [String]
      # @return [Vedeu::Borders::Border]
      def self.update(name, title)
        new(name, title).update
      end

      # @param name [String|Symbol]
      # @param title [String]
      # @return [Vedeu::Borders::SetTitle]
      def initialize(name, title)
        @name  = name
        @title = title
      end

      # @return [Vedeu::Borders::Border]
      def update
        border.title = title
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

      # @return [String] The new title.
      def title
        if present?(@title)
          @title

        else
          ''

        end
      end

    end # SetTitle

  end # Borders

end # Vedeu
