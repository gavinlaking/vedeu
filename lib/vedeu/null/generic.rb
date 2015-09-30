module Vedeu

  module Null

    # Provides a non-existent model to swallow messages.
    #
    class Generic

      # @!attribute [r] attributes
      # @return [String]
      attr_reader :attributes

      # @!attribute [r] name
      # @return [String|Symbol]
      attr_reader :name

      # Returns an instance of the Vedeu::Null::Generic class.
      #
      # @param attributes [Hash<Symbol => void>]
      # @option attributes name [String|Symbol|NilClass]
      # @return [Vedeu::Null::Generic]
      def initialize(attributes = {})
        @attributes = attributes
        @name       = @attributes[:name]
      end

      # @return [FalseClass]
      def falsy
        false
      end
      alias_method :centred, :falsy
      alias_method :enabled?, :falsy
      alias_method :maximise, :falsy
      alias_method :maximised?, :falsy
      alias_method :unmaximise, :falsy

      # @return [NilClass]
      def null(*)
        nil
      end
      alias_method :add,           :null
      alias_method :bottom_item,   :null
      alias_method :clear,         :null
      alias_method :colour,        :null
      alias_method :current_item,  :null
      alias_method :deselect_item, :null
      alias_method :hide,          :null
      alias_method :item,          :null
      alias_method :items,         :null
      alias_method :next_item,     :null
      alias_method :parent,        :null
      alias_method :prev_item,     :null
      alias_method :render,        :null
      alias_method :select_item,   :null
      alias_method :selected_item, :null
      alias_method :show,          :null
      alias_method :style,         :null
      alias_method :toggle,        :null
      alias_method :top_item,      :null
      alias_method :view,          :null
      alias_method :zindex,        :null

      # @return [Boolean]
      def null?
        true
      end

      # @return [Vedeu::Null::Generic]
      def store
        self
      end

      # The generic null should not be visible.
      #
      # @return [FalseClass]
      def visible?
        false
      end
      alias_method :visible, :visible?

      # @return [FalseClass]
      def visible=(*)
        false
      end

    end # Generic

  end # Null

end # Vedeu
