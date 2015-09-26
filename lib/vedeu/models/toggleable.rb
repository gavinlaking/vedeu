module Vedeu

  # This module provides behaviour for certain classes which can be
  # toggled between being shown and hidden.
  #
  # Currently using this are: {Vedeu::Cursors::Cursor},
  # {Vedeu::Models::Group} and {Vedeu::Models::Interface}.
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
      if visible?
        hide

      else
        show

      end
    end

    # Provide class methods to models to allow the visibility to be
    # changed.
    #
    module ClassMethods

      # Hides the model.
      #
      # @param name [String]
      # @return [void]
      def hide(name = nil)
        model_by_name(repository, name).hide
      end
      alias_method :hide_cursor,    :hide
      alias_method :hide_group,     :hide
      alias_method :hide_interface, :hide

      # Shows the model.
      #
      # @param name [String]
      # @return [void]
      def show(name = nil)
        model_by_name(repository, name).show
      end
      alias_method :show_cursor,    :show
      alias_method :show_group,     :show
      alias_method :show_interface, :show

      # Toggles the visibility of the model.
      #
      # @param name [String]
      # @return [void]
      def toggle(name = nil)
        model_by_name(repository, name).toggle
      end
      alias_method :toggle_cursor,    :toggle
      alias_method :toggle_group,     :toggle
      alias_method :toggle_interface, :toggle

      private

      # Fetch the model by name.
      #
      # @param name [String]
      # @param klass [void] The repository of the model.
      # @return [void]
      def model_by_name(klass, name = nil)
        klass.by_name(name || Vedeu.focus)
      end

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
