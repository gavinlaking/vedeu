module Vedeu

  # Converts the collection passed into a list of menu items which can be
  # navigated using the instance methods or events provided.
  #
  # @api private
  class Menu

    include Model

    # Returns a new instance of Menu.
    #
    # @param collection [Array]
    # @param name [String]
    # @return [Menu]
    def initialize(collection, name = '')
      @collection = collection
      @name       = name
      @current    = 0
      @selected   = nil
    end

    # Returns the class responsible for defining the DSL methods of this model.
    #
    # @return [DSL::Interface]
    def deputy
      Vedeu::DSL::Menu.new(self)
    end

    # Returns the index of the value in the collection which is current.
    #
    # @return [Fixnum]
    def current
      @current
    end

    # Returns the index of the value in the collection which is selected.
    #
    # @return [Fixnum]
    def selected
      @selected
    end

    # Returns the item from the collection which shares the same index as the
    # value of {Vedeu::Menu#current}.
    #
    # @return []
    def current_item
      @collection[@current]
    end

    # Returns the item from the collection which shares the same index as the
    # value of {Vedeu::Menu#selected}.
    #
    # @return [|NilClass]
    def selected_item
      return nil unless @selected

      @collection[@selected]
    end

    # Returns a new collection of items.
    # Each element of the collection is of the format:
    #
    #   [ selected, current, item ]
    #
    # `selected` is a boolean indicating whether the item is selected.
    # `current`  is a boolean indicating whether the item is current.
    # `item`     is the item itself.
    #
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

    # Returns a subset of all the items.
    #
    # @return [Array]
    def view
      items[@current, @collection.size]
    end

    # Sets the value of current to be the first item of the collection.
    #
    # @return [Array]
    def top_item
      @current = 0

      items
    end

    # Sets the value of current to be the last item of the collection.
    #
    # @return [Array]
    def bottom_item
      @current = last

      items
    end

    # Sets the value of current to be the next item in the collection until we
    # reach the last.
    #
    # @return [Array]
    def next_item
      @current += 1 if @current < last

      items
    end

    # Sets the value of current to be the previous item in the collection until
    # we reach the first.
    #
    # @return [Array]
    def prev_item
      @current -= 1 if @current > 0

      items
    end

    # Sets the selected item to be the same value as the current item.
    #
    # @return [Array]
    def select_item
      @selected = @current

      items
    end

    # Removes the value of `selected`, meaning no items are selected.
    #
    # @return [Array]
    def deselect_item
      @selected = nil

      items
    end

    # Returns the last index of the collection.
    #
    # @return [Fixnum]
    def last
      @collection.size - 1
    end

    # Returns the size of the collection.
    #
    # @return [Fixnum]
    def size
      @collection.size
    end

    private

    # @return [Class] The repository class for this model.
    def repository
      Vedeu::Menus
    end

  end # Menu

end # Vedeu
