require 'vedeu/support/esc'

module Vedeu

  class Visible

    def self.coerce(value)
      if value.is_a?(self)
        value

      else
        new(value)

      end
    end

    def initialize(visible = nil)
      @visible = if visible == :hide || visible == false
        false

      elsif visible == :show || visible == true
        true

      else
        !!visible

      end
    end

    def inspect
      "<#{self.class.name} (#{@visible.to_s})>"
    end

    def cursor
      if visible?
        Esc.string('show_cursor')

      else
        Esc.string('hide_cursor')

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
