module Vedeu
  class Menu
    def initialize(collection)
      @collection = collection
      @current    = 0
      @selected   = nil
    end

    def current
      @current
    end

    def selected
      @selected
    end

    def current_item
      [@current, @collection[@current]]
    end

    def selected_item
      return nil unless @selected

      [@selected, @collection[@selected]]
    end

    def items
      items = []
      @collection.each_with_index do |item, index|
        if index    == @current && index == @selected
          items << [true, true, item]

        elsif index == @current
          items << [false, true, item]

        elsif index == @selected
          items << [true, false, item]

        else
          items << [false, false, item]

        end
      end
      items
    end

    def render
      lines = []
      items.each do |(sel, cur, item)|
        if sel && cur
          lines << "*> #{item}"

        elsif cur
          lines << " > #{item}"

        elsif sel
          lines << "*  #{item}"

        else
          lines << "   #{item}"

        end
      end
      lines
    end

    def top
      @current = 0
    end

    def bottom
      @current = last
    end

    def next
      @current += 1 if @current < last

      self
    end

    def prev
      @current -= 1 if @current > 0

      self
    end

    def select
      @selected = @current
    end

    def deselect
      @selected = nil
    end

    def last
      @collection.size - 1
    end

    def size
      @collection.size
    end
  end
end
