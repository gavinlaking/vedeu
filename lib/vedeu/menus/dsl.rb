module Vedeu

  module Menus

    # Provides the mechanism to create menus within client
    # applications and use events to drive them.
    #
    class DSL

      include Vedeu::DSL

      class << self

        # Register a menu by name which will display a collection of
        # items for your users to select; and provide interactivity
        # within your application.
        #
        # @param name [String|Symbol]
        # @param block [Proc] A set of attributes which define the
        #   features of the menu. See {Vedeu::Menus::DSL#items} and
        #   {Vedeu::Menus::DSL#name}.
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
        # @raise [Vedeu::Error::RequiresBlock]
        # @return [API::Menu]
        def menu(name = '', &block)
          fail Vedeu::Error::RequiresBlock unless block_given?

          attributes = { client: client(&block), name: name }

          Vedeu::Menus::Menu.build(attributes, &block).store
        end

        private

        # Returns the client object which called the DSL method.
        #
        # @param block [Proc]
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
      alias_method :item=, :item

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
      alias_method :items=, :items

      # The name of the menu. Used to reference the menu throughout
      # your application's execution lifetime.
      #
      #   Vedeu.menu do
      #     name :my_menu
      #     # ...
      #   end
      #
      # @param name [String|Symbol]
      # @return [String]
      def name(name)
        model.name = name
      end
      alias_method :name=, :name

    end # DSL

  end # Menus

end # Vedeu
