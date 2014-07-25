require 'vedeu'
require 'vedeu/support/events'

module Vedeu
  class Menu
    def initialize(collection)
      @collection = collection
      @current    = 0
      @selected   = nil
      @events     = events
    end

    def events
      @_events ||= Vedeu.events.add(self) do
        on(:menu_next)     { next_item     }
        on(:menu_prev)     { prev_item     }
        on(:menu_top)      { top_item      }
        on(:menu_bottom)   { bottom_item   }
        on(:menu_select)   { select_item   }
        on(:menu_deselect) { deselect_item }

        on(:menu_selected) { selected_item }
        on(:menu_current)  { current_item  }
        on(:menu_items)    { items         }
        on(:menu_render)   { render        }
      end
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

    def top_item
      @current = 0

      items
    end

    def bottom_item
      @current = last

      items
    end

    def next_item
      @current += 1 if @current < last

      items
    end

    def prev_item
      @current -= 1 if @current > 0

      items
    end

    def select_item
      @selected = @current

      items
    end

    def deselect_item
      @selected = nil

      items
    end

    def last
      @collection.size - 1
    end

    def size
      @collection.size
    end
  end
end
