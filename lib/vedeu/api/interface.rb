module Vedeu
  module API
    class Interface < Vedeu::Interface

      def self.define(attributes = {}, &block)
        new(attributes).define(&block)
      end

      # @param block [Proc]
      #
      # @example
      #   TODO
      #
      # @return []
      def define(&block)
        instance_eval(&block) if block_given?

        Vedeu::Store.create(attributes)
      end

      # Define a single line in a view.
      #
      # @param block [Proc]
      #
      # @example
      #   view 'my_interface' do
      #     line do
      #       ... some line attributes ...
      #     end
      #   end
      #
      # @return []
      def line(&block)
        attributes[:lines] << Line.build(&block)
      end

      # @see Vedeu::API#use
      def use(value)
        Vedeu.use(value)
      end

      # Define the default colour attributes for an interface.
      #
      # @param value [Hash]
      #
      # @example
      #   interface 'my_interface' do
      #     colour background: '#000000', foreground: '#ffffff'
      #     ... some interface attributes ...
      #   end
      #
      # @return []
      def colour(value)
        attributes[:colour] = value
      end

      # Define the cursor visibility for an interface. A `true` value will show
      # the cursor, whilst `false` will hide it.
      #
      # @param value [Boolean]
      #
      # @example
      #   interface 'my_interface' do
      #     cursor true
      #     ... some interface attributes ...
      #   end
      #
      # @return []
      def cursor(value)
        attributes[:cursor] = value
      end

      # @param value [Fixnum|Float]
      #
      # @return []
      def delay(value)
        attributes[:delay] = value
      end

      # Define a group for an interface. Interfaces of the same group can be
      # targetted together; for example you may want to refresh multiple
      # interfaces at once.
      #
      # @param value [String]
      #
      # @example
      #   interface 'my_interface' do
      #     group 'main_screen' do
      #     ... some interface attributes ...
      #   end
      #
      # @return []
      def group(value)
        attributes[:group] = value
      end

      # The name of the interface. Used to reference the interface throughout
      # your application's execution lifetime.
      #
      # @param value [String]
      #
      # @example
      #   TODO
      #
      # @return []
      def name(value)
        attributes[:name] = value
      end

      # Define the starting x position (column) of the interface.
      #
      # @param value [Fixnum]
      #
      # @example
      #   TODO
      #
      # @return []
      def x(value)
        fail XOutOfBounds if x_out_of_bounds?(value)

        attributes[:geometry][:x] = value
      end

      # Define the starting y position (row/line) of the interface.
      #
      # @param value [Fixnum]
      #
      # @example
      #   TODO
      #
      # @return []
      def y(value)
        fail YOutOfBounds if y_out_of_bounds?(value)

        attributes[:geometry][:y] = value
      end

      # Define the number of characters/columns wide the interface will be.
      #
      # @param value [Fixnum]
      #
      # @example
      #   TODO
      #
      # @return []
      def width(value)
        fail InvalidWidth if x_out_of_bounds?(value)

        attributes[:geometry][:width] = value
      end

      # Define the number of characters/rows/lines tall the interface will be.
      #
      # @param value [Fixnum]
      #
      # @example
      #   TODO
      #
      # @return []
      def height(value)
        fail InvalidHeight if y_out_of_bounds?(value)

        attributes[:geometry][:height] = value
      end

      # Instructs Vedeu to calculate x and y geometry automatically based on the
      # centre character of the terminal, the width and the height.
      #
      # @param value [Boolean]
      #
      # @example
      #   TODO
      #
      # @return []
      def centred(value)
        attributes[:geometry][:centred] = value
      end

      # Define the default style attributes for an interface.
      #
      # @param value [Array|String]
      #
      # @example
      #   TODO
      #
      # @return []
      def style(value)
        attributes[:style] = value
      end

      private

      def y_out_of_bounds?(value)
        value < 1 || value > Terminal.height
      end

      def x_out_of_bounds?(value)
        value < 1 || value > Terminal.width
      end

      def method_missing(method, *args, &block)
        @self_before_instance_eval.send(method, *args, &block)
      end

    end
  end
end
