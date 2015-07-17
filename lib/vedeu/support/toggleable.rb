module Vedeu

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

  end # Toggleable

end # Vedeu
