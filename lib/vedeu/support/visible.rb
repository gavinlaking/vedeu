module Vedeu

  class Visible

    def initialize(visible = nil)
      @visible = if visible == :hide
        false

      elsif visible == :show
        true

      else
        !!visible

      end
    end

    def visible?
      @visible
    end

    def invisible?
      !@visible
    end

    def hide
      Visible.new(false)
    end

    def show
      Visible.new(true)
    end

    def toggle
      visible? ? hide : show
    end

  end # Visible

end # Vedeu
