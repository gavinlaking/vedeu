module Vedeu

  module DSL

    # Provides the mechanism to create menus within client applications and use
    # events to drive them.
    #
    # @api public
    class Menu

      include Vedeu::DSL

      # Return a new instance of DSL::Menu.
      #
      # @param model [Vedeu::Menu]
      # @return      [DSL::Menu]
      def initialize(model, client = nil)
        @model  = model
        @client = client
      end

      # Add an individual item to the menu.
      #
      # @param element [Object] An object you wish to add to the collection.
      #
      # @example
      #   menu 'my_menu' do
      #     item SomeClass.new
      #     item SomeClass.new
      #
      # @return [Array]
      def item(element)
        model.collection << element
      end

      # Define the items for the menu. Most powerful when used with one of your
      # model classes.
      #
      # In the 'my_playlist' example below, your `Track` model may return a
      # collection of tracks to populate the menu.
      #
      # @param collection [Array<Object>] A collection of objects which make up
      #   the menu items.
      #
      # @example
      #   menu 'my_menu' do
      #     items [:item_1, :item_2, :item_3]
      #   end
      #
      #   menu 'my_playlist' do
      #     items Track.all_my_favourites
      #   end
      #
      # @return [Array]
      def items(collection = [])
        model.collection = collection
      end

      # The name of the menu. Used to reference the menu throughout your
      # application's execution lifetime.
      #
      # @param value [String]
      #
      # @example
      #   menu do
      #     name 'my_menu'
      #     ...
      #
      # @return [String]
      def name(value)
        model.name = value
      end

      private

      attr_reader :client, :model

    end # Menu

  end # DSL

end # Vedeu
