module Vedeu
  module API

    # Provides the mechanism to create menus within client applications and use
    # events to drive them.
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
      # @return [API::Menu]
      def define(&block)
        fail InvalidSyntax, '`menu` requires a block.' unless block_given?

        @self_before_instance_eval = eval('self', block.binding)

        instance_eval(&block)

        validate_attributes!

        Vedeu::Menus.add(attributes)

        self
      end

      # Define the items for the menu. Most powerful when used with one of your
      # model classes.
      #
      # In the 'my_playlist' example below, your `Track` model may return a
      # collection of tracks to populate the menu.
      #
      # @api public
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
        attributes[:items] = Vedeu::Menu.new(collection)
      end

      # The name of the menu. Used to reference the menu throughout your
      # application's execution lifetime.
      #
      # @api public
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
      # @api private
      # @return [Hash]
      def defaults
        {
          name:  '',
          items: []
        }
      end

      # @api private
      # @return [TrueClass|FalseClass]
      def validate_attributes!
        unless defined_value?(attributes[:name])
          fail InvalidSyntax, 'Menus must have a `name`.'
        end
      end

      # @api private
      # @return []
      def method_missing(method, *args, &block)
        @self_before_instance_eval.send(method, *args, &block)
      end

    end
  end
end
