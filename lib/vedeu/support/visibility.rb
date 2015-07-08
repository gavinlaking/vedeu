module Vedeu

  # Change the visibility of the given model.
  #
  # @api private
  class Visibility

    # @param name [String]
    # @return [Vedeu::Visibility]
    def self.for_cursor(name = nil)
      model = name ? Vedeu.cursors.by_name(name) : Vedeu.cursor

      new(model)
    end

    # @param name [String]
    # @return [Vedeu::Visibility]
    def self.hide_cursor(name = nil)
      model = name ? Vedeu.cursors.by_name(name) : Vedeu.cursor

      new(model).hide
    end

    # @param name [String]
    # @return [Vedeu::Visibility]
    def self.show_cursor(name = nil)
      model = name ? Vedeu.cursors.by_name(name) : Vedeu.cursor

      new(model).show
    end

    # @param model [void]
    # @return [void]
    def self.show(model)
      new(model).show
    end

    # @param model [void]
    # @return [void]
    def self.hide(model)
      new(model).hide
    end

    # @param model [void]
    # @return [void]
    def self.toggle(model)
      new(model).toggle
    end

    # Returns a new instance of Vedeu::Visibility.
    #
    # @param model [void]
    # @return [Vedeu::Visibility]
    def initialize(model)
      @model = model
    end

    # @return [void]
    def show
      if model.visible?
        model

      else
        model.visible = true
        model.store

      end
    end

    # @return [Symbol]
    def state
      if model.visible?
        :visible

      else
        :invisible

      end
    end

    # @return [void]
    def hide
      if model.visible?
        model.visible = false
        model.store

      else
        model

      end
    end

    # @return [void]
    def toggle
      if model.visible?
        hide

      else
        show

      end
    end

    protected

    # @!attribute [r] model
    # @return [void]
    attr_reader :model

  end # Visibility

end # Vedeu
