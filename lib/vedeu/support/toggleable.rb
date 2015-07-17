module Vedeu

  # Toggleable instance methods for certain models.
  #
  # @api private
  module Toggleable

    # @!attribute [rw] visible
    # @return [Boolean] Whether the toggleable is visible.
    attr_accessor :visible
    alias_method :visible?, :visible

    # @return [FalseClass]
    def hide
      @visible = false

      store
    end

    # @return [TrueClass]
    def show
      @visible = true

      store
    end

    # @return [FalseClass|TrueClass]
    def toggle
      if visible?
        hide

      else
        show

      end
    end

    # Toggleable class methods for models.
    #
    # @api private
    module ClassMethods

      # @param name [String]
      # @return [void]
      def hide(name = nil)
        model_by_name(name, self.repository).hide
      end
      alias_method :hide_cursor,    :hide
      alias_method :hide_group,     :hide
      alias_method :hide_interface, :hide

      # @param name [String]
      # @return [void]
      def show(name = nil)
        model_by_name(name, self.repository).show
      end
      alias_method :show_cursor,    :show
      alias_method :show_group,     :show
      alias_method :show_interface, :show

      # @param name [String]
      # @return [void]
      def toggle(name = nil)
        model_by_name(name, self.repository).toggle
      end
      alias_method :toggle_cursor,    :toggle
      alias_method :toggle_group,     :toggle
      alias_method :toggle_interface, :toggle

      private

      # @param name [String]
      # @param klass [void] The repository of the model.
      # @return [void]
      def model_by_name(name = nil, klass)
        klass.by_name(model_name(name))
      end

      # @param name [String]
      # @return [void]
      def model_name(name = nil)
        return name || Vedeu.focus
      end

    end # ClassMethods

    # When this module is included in a class, provide ClassMethods as class
    # methods for the class.
    #
    # @param klass [Class]
    # @return [void]
    def self.included(klass)
      klass.send :extend, ClassMethods
    end

  end # Toggleable

end # Vedeu
