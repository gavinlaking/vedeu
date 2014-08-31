module Vedeu
  class Menu

    # @param collection []
    # @return [Menu]
    def initialize(collection)
      @collection = collection
      @current    = 0
      @selected   = nil
      @events     = events
    end

    # @return []
    def events
      @_events ||= Vedeu.events.add(self) do
        event(:menu_next)     { next_item     }
        event(:menu_prev)     { prev_item     }
        event(:menu_top)      { top_item      }
        event(:menu_bottom)   { bottom_item   }
        event(:menu_select)   { select_item   }
        event(:menu_deselect) { deselect_item }

        event(:menu_selected) { selected_item }
        event(:menu_current)  { current_item  }
        event(:menu_items)    { items         }
      end
    end

    # @return []
    def current
      @current
    end

    # @return []
    def selected
      @selected
    end

    # @return []
    def current_item
      @collection[@current]
    end

    # @return []
    def selected_item
      return nil unless @selected

      @collection[@selected]
    end

    # @return [Array]
    def items
      items = []
      @collection.each_with_index do |item, index|
        if index == @current && index == @selected
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

    # @return [Array]
    def view
      items[@current, @collection.size]
    end

    # @return [Array]
    def top_item
      @current = 0

      items
    end

    # @return [Array]
    def bottom_item
      @current = last

      items
    end

    # @return [Array]
    def next_item
      @current += 1 if @current < last

      items
    end

    # @return [Array]
    def prev_item
      @current -= 1 if @current > 0

      items
    end

    # @return [Array]
    def select_item
      @selected = @current

      items
    end

    # @return [Array]
    def deselect_item
      @selected = nil

      items
    end

    # @return [Fixnum]
    def last
      @collection.size - 1
    end

    # @return [Fixnum]
    def size
      @collection.size
    end

  end
end
