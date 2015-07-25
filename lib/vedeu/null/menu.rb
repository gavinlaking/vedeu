module Vedeu

  module Null

    # Provides a non-existent model to swallow messages.
    #
    class Menu

      # Returns an instance of the Vedeu::Null::Menu class.
      #
      # @param attributes [Hash<Symbol => void>]
      # @option attributes name [String|NilClass]
      # @return [Vedeu::Null::Menu]
      def initialize(attributes = {})
        @attributes = attributes
        @name       = @attributes[:name]
      end

      # @return [NilClass]
      def item
        nil
      end
      alias_method :bottom_item, :item
      alias_method :current_item, :item
      alias_method :deselect_item, :item
      alias_method :items, :item
      alias_method :next_item, :item
      alias_method :prev_item, :item
      alias_method :select_item, :item
      alias_method :selected_item, :item
      alias_method :top_item, :item
      alias_method :view, :item

    end # Menu

  end # Null

end # Vedeu
