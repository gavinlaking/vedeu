module Vedeu

  # This module provides behaviour for certain classes which can be
  # toggled between being shown and hidden.
  #
  # Currently using this are: {Vedeu::Cursors::Cursor},
  # {Vedeu::Groups::Group} and {Vedeu::Interfaces::Interface}.
  #
  module Toggleable

    # @!attribute [rw] visible
    # @return [Boolean] Whether the toggleable is visible.
    attr_accessor :visible
    alias_method :visible?, :visible

    # Set the visible state to false and store the model.
    #
    # @return [FalseClass]
    def hide
      @visible = false

      store
    end

    # Set the visible state to true and store the model.
    #
    # @return [TrueClass]
    def show
      @visible = true

      store
    end

    # Toggle the visible state and store the model. When the model is
    # hidden, then it is shown, and vice versa.
    #
    # @return [FalseClass|TrueClass]
    def toggle
      return hide if visible?

      show
    end

    # Provide class methods to models to allow the visibility to be
    # changed.
    #
    module ClassMethods

      # Hides the model.
      #
      # @example
      #   Vedeu.hide_cursor(name)
      #   Vedeu.hide_group(name)
      #   Vedeu.hide_interface(name)
      #
      # @param name [String|Symbol]
      # @return [void]
      def hide(name = Vedeu.focus)
        repository.by_name(name).hide
      end
      alias_method :hide_cursor,    :hide
      alias_method :hide_group,     :hide
      alias_method :hide_interface, :hide

      # Shows the model.
      #
      # @example
      #   Vedeu.show_cursor(name)
      #   Vedeu.show_group(name)
      #   Vedeu.show_interface(name)
      #
      # @param name [String|Symbol]
      # @return [void]
      def show(name = Vedeu.focus)
        repository.by_name(name).show
      end
      alias_method :show_cursor,    :show
      alias_method :show_group,     :show
      alias_method :show_interface, :show

      # Toggles the visibility of the model.
      #
      # @example
      #   Vedeu.toggle_cursor(name)
      #   Vedeu.toggle_group(name)
      #   Vedeu.toggle_interface(name)
      #
      # @param name [String|Symbol]
      # @return [void]
      def toggle(name = Vedeu.focus)
        repository.by_name(name).toggle
      end
      alias_method :toggle_cursor,    :toggle
      alias_method :toggle_group,     :toggle
      alias_method :toggle_interface, :toggle

    end # ClassMethods

    # When this module is included in a class, provide ClassMethods as
    # class methods for the class.
    #
    # @param klass [Class]
    # @return [void]
    def self.included(klass)
      klass.send(:extend, ClassMethods)
    end

  end # Toggleable

end # Vedeu
