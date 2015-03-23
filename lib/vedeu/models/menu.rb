require 'vedeu/repositories/model'

module Vedeu

  # Converts the collection passed into a list of menu items which can be
  # navigated using the instance methods or events provided.
  #
  class Menu

    include Vedeu::Model

    # @!attribute [rw] collection
    # @return [Array]
    attr_accessor :collection

    # Returns the index of the value in the collection which is current.
    #
    # @!attribute [rw] current
    # @return [Fixnum]
    attr_accessor :current

    # The name of the menu. Used to reference the menu throughout the
    # application's execution lifetime.
    #
    # @!attribute [rw] name
    # @return [String]
    attr_accessor :name

    # Returns the index of the value in the collection which is selected.
    #
    # @!attribute [rw] selected
    # @return [Fixnum]
    attr_accessor :selected

    # Register a menu by name which will display a collection of items for
    # your users to select; and provide interactivity within your application.
    #
    # @param name [String]
    # @param block [Proc] A set of attributes which define the features of the
    #   menu. See {Vedeu::DSL::Menu#items} and {Vedeu::DSL::Menu#name}.
    #
    # @example
    #   Vedeu.menu 'my_interface' do
    #     items [:item_1, :item_2, :item_3]
    #     ...
    #
    #   Vedeu.menu do
    #     name 'menus_must_have_a_name'
    #     items Track.all_my_favourites
    #     ...
    #
    # @raise [InvalidSyntax] The required block was not given.
    # @return [API::Menu]
    def self.menu(name = '', &block)
      fail InvalidSyntax, 'block not given' unless block_given?

      build({ name: name }, &block).store
    end

    # Returns a new instance of Vedeu::Menu.
    #
    # @param attributes [Hash]
    # @option attributes collection [Array]
    # @option attributes name [String]
    # @option attributes current [Fixnum]
    # @option attributes selected [Fixnum|NilClass]
    # @return [Menu]
    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)
      @collection = @attributes[:collection]
      @current    = @attributes[:current]
      @name       = @attributes[:name]
      @repository = Vedeu.menus
      @selected   = @attributes[:selected]
    end

    # Returns the item from the collection which shares the same index as the
    # value of {Vedeu::Menu#current}.
    #
    # @return [void]
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

    # The default values for a new instance of this class.
    #
    # @return [Hash]
    def defaults
      {
        client:     nil,
        collection: [],
        current:    0,
        name:       '',
        selected:   nil,
      }
    end

  end # Menu

end # Vedeu
