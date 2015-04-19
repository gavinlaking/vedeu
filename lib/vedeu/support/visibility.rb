module Vedeu

  # Change the visibility of the given model.
  class Visibility

    # @param name [String]
    # @return [Vedeu::Visibility]
    def self.for_cursor(name = nil)
      named = name ? Vedeu.cursors.by_name(name) : Vedeu.cursor

      new(named)
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

    # @param model [void]
    # @return [Vedeu::Visibility]
    def initialize(model)
      @model = model
    end

    # @return [void]
    def show
      model.visible = true
      model.store
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
      model.visible = false
      model.store
    end

    # @return [void]
    def toggle
      if model.visible?
        hide

      else
        show

      end
    end

    private

    # @!attribute [r] model
    # @return [void]
    attr_reader :model

  end # Visibility

end # Vedeu
