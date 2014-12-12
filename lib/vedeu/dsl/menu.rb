module Vedeu

  module DSL

    # Provides the mechanism to create menus within client applications and use
    # events to drive them.
    #
    # @api public
    class Menu

      # Return a new instance of DSL::Menu.
      #
      # @param model [Vedeu::Menu]
      # @return      [DSL::Menu]
      def initialize(model = Vedeu::Menu.new)
        @model = model
      end

      # Define the items for the menu. Most powerful when used with one of your
      # model classes.
      #
      # In the 'my_playlist' example below, your `Track` model may return a
      # collection of tracks to populate the menu.
      #
      # @param collection [Array]
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
        model.set_items(collection)
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
        model.set_name(value)
      end

      private

      attr_reader :model

    end # Menu

  end # DSL

end # Vedeu
