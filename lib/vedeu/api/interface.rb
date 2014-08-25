module Vedeu
  module API
    class Interface < Vedeu::Interface
      include Helpers

      # @param attributes [Hash]
      # @param block [Proc]
      # @return []
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
      # @param block [Proc]
      #
      # @example
      #   interface 'my_interface' do
      #     x 7 # start on column 7.
      #
      #   interface 'other_interface' do
      #     x { use('my_interface').east } # start on column 8, if
      #                                    # `my_interface` changes position,
      #                                    # `other_interface` will too.
      #
      # @return []
      def x(value = 0, &block)
        if block_given?
          attributes[:geometry][:x] = block

        else
          Vedeu.log(out_of_bounds('x')) if x_out_of_bounds?(value)

          attributes[:geometry][:x] = value

        end
      end

      # Define the starting y position (row/line) of the interface.
      #
      # @param value [Fixnum]
      # @param block [Proc]
      #
      # @example
      #   interface 'my_interface' do
      #     y  4
      #     ...
      #
      #   interface 'other_interface' do
      #     y  { use('my_interface').north } # start on row/line 3, if
      #     ...                              # `my_interface` changes position,
      #                                      # `other_interface` will too.
      #
      # @return []
      def y(value = 0, &block)
        if block_given?
          attributes[:geometry][:y] = block

        else
          Vedeu.log(out_of_bounds('y')) if y_out_of_bounds?(value)

          attributes[:geometry][:y] = value

        end
      end

      # Define the number of characters/columns wide the interface will be.
      #
      # @param value [Fixnum]
      #
      # @example
      #   interface 'my_interface' do
      #     width 25
      #     ...
      #
      # @return []
      def width(value)
        Vedeu.log(out_of_bounds('width')) if x_out_of_bounds?(value)

        attributes[:geometry][:width] = value
      end

      # Define the number of characters/rows/lines tall the interface will be.
      #
      # @param value [Fixnum]
      #
      # @example
      #   interface 'my_interface' do
      #     height 8
      #     ...
      #
      # @return []
      def height(value)
        Vedeu.log(out_of_bounds('height')) if y_out_of_bounds?(value)

        attributes[:geometry][:height] = value
      end

      # Instructs Vedeu to calculate x and y geometry automatically based on the
      # centre character of the terminal, the width and the height.
      #
      # @param value [Boolean]
      #
      # @example
      #   interface 'my_interface' do
      #     centred true
      #     ...
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
      #   interface 'my_interface' do
      #     style ['underline', 'bold']
      #     ...
      #
      # @return []
      def style(value)
        attributes[:style] = value
      end

      private

      def out_of_bounds(name)
        "Note: For this terminal, the value of '#{name}' may lead to content " \
        "that is outside the viewable area."
      end

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
