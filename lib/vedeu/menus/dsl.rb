# frozen_string_literal: true

module Vedeu

  module Menus

    # Provides the mechanism to create menus within client
    # applications and use events to drive them.
    #
    # @api public
    #
    class DSL

      include Vedeu::DSL

      class << self

        # Register a menu by name which will display a collection of
        # items for your users to select; and provide interactivity
        # within your application.
        #
        # @macro param_name
        # @macro param_block
        #
        # @example
        #   Vedeu.menu :my_interface do
        #     items [:item_1, :item_2, :item_3]
        #     # ...
        #   end
        #
        #   Vedeu.menu do
        #     name :menus_must_have_a_name
        #     items Track.all_my_favourites
        #     # ...
        #   end
        #
        # @macro raise_requires_block
        # @macro raise_missing_required
        # @return [API::Menu]
        def menu(name, &block)
          raise Vedeu::Error::MissingRequired unless name
          raise Vedeu::Error::RequiresBlock unless block_given?

          attributes = { client: client(&block), name: name }

          Vedeu::Menus::Menu.build(attributes, &block).store
        end

        private

        # Returns the client object which called the DSL method.
        #
        # @macro param_block
        # @return [Object]
        def client(&block)
          eval('self', block.binding)
        end

      end # Eigenclass

      # Add an individual item to the menu.
      #
      # @param element [Object] An object you wish to add to the
      #   collection.
      #
      #   Vedeu.menu :my_menu do
      #     item SomeClass.new
      #     item SomeClass.new
      #   end
      #
      # @return [Array]
      def item(element)
        model.collection << element
      end
      alias item= item

      # Define the items for the menu. Most powerful when used with
      # one of your model classes.
      #
      # In the :my_playlist example below, your `Track` model may
      # return a collection of tracks to populate the menu.
      #
      #   Vedeu.menu :my_menu do
      #     items [:item_1, :item_2, :item_3]
      #   end
      #
      #   Vedeu.menu :my_playlist do
      #     items Track.all_my_favourites
      #   end
      #
      # @param collection [Array<Object>] A collection of objects
      #   which make up the menu items.
      # @return [Array]
      def items(collection = [])
        model.collection = collection
      end
      alias items= items

    end # DSL

  end # Menus

end # Vedeu
