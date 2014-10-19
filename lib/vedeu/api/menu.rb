module Vedeu

  module API

    # Provides the mechanism to create menus within client applications and use
    # events to drive them.
    #
    # @api public
    class Menu

      include Common

      attr_reader :attributes

      # @param attributes [Hash]
      # @param block [Proc]
      # @return [API::Menu]
      def self.define(attributes = {}, &block)
        new(attributes).define(&block)
      end

      # Return a new instance of Menu.
      #
      # @param  attributes [Hash]
      # @return [API::Menu]
      def initialize(attributes = {})
        @attributes = defaults.merge!(attributes)
      end

      # @param block [Proc]
      # @raise [InvalidSyntax] When the required block is not given.
      # @return [API::Menu]
      def define(&block)
        fail InvalidSyntax, '`menu` requires a block.' unless block_given?

        @self_before_instance_eval = eval('self', block.binding)

        instance_eval(&block)

        Vedeu::Menus.add(attributes)

        self
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
      # @return [Vedeu::Menu]
      def items(collection = [])
        attributes[:items] = collection
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
        attributes[:name] = value
      end

      private

      # The default values for a new instance of Menu.
      #
      # @return [Hash]
      def defaults
        {
          name:  '',
          items: []
        }
      end

      # @param method [Symbol] The name of the method sought.
      # @param args [Array] The arguments which the method was to be invoked
      #   with.
      # @param block [Proc] The optional block provided to the method.
      # @return []
      def method_missing(method, *args, &block)
        Vedeu.log("API::Menu#method_missing '#{method.to_s}' (args: #{args.inspect})")

        @self_before_instance_eval.send(method, *args, &block) if @self_before_instance_eval
      end

    end # Menu

  end # API

end # Vedeu
