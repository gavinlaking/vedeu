module Vedeu
  module API
    class Interface < Vedeu::Interface
      include Helpers

      # Define a single line in a view.
      #
      # @api public
      # @param value [String]
      # @param block [Proc]
      #
      # @example
      #   view 'my_interface' do
      #     line 'This is a line of text...'
      #     line 'and so is this...'
      #     ...
      #
      #   view 'my_interface' do
      #     line do
      #       ... some line attributes ...
      #     end
      #   end
      #
      # @return [API::Interface]
      def line(value = '', &block)
        if block_given?
          attributes[:lines] << Line.build({ parent: self }, &block)

        else
          attributes[:lines] << Line.build({ parent: self,
                                             streams: { text: value } })

        end
      end

      # Use the specified interface; useful for sharing attributes with other
      # interfaces.
      #
      # @api public
      # @param value [String]
      # @see Vedeu::API#use
      def use(value)
        Vedeu.use(value)
      end

      # Define the cursor visibility for an interface. A `true` value will show
      # the cursor, whilst `false` will hide it.
      #
      # @api public
      # @param value [Boolean]
      #
      # @example
      #   interface 'my_interface' do
      #     cursor true
      #     ...
      #
      # @return [API::Interface]
      def cursor(value)
        unless value.is_a?(TrueClass) || value.is_a?(FalseClass)
          fail InvalidSyntax, 'Argument must be `true` or `false` for cursor.'
        end

        attributes[:cursor] = value
      end

      # To maintain performance interfaces can be delayed from refreshing too
      # often, the reduces artefacts particularly when resizing the terminal
      # screen.
      #
      # @api public
      # @param value [Fixnum|Float]
      #
      # @return [API::Interface]
      def delay(value)
        attributes[:delay] = value
      end

      # Define a group for an interface. Interfaces of the same group can be
      # targetted together; for example you may want to refresh multiple
      # interfaces at once.
      #
      # @api public
      # @param value [String]
      #
      # @example
      #   interface 'my_interface' do
      #     group 'main_screen'
      #     ...
      #
      # @return [API::Interface]
      def group(value)
        attributes[:group] = value
      end

      # The name of the interface. Used to reference the interface throughout
      # your application's execution lifetime.
      #
      # @api public
      # @param value [String]
      #
      # @example
      #   interface do
      #     name 'my_interface'
      #     ...
      #
      # @return [API::Interface]
      def name(value)
        attributes[:name] = value
      end

      # Define the starting x position (column) of the interface.
      #
      # @api public
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
      # @return [API::Interface]
      def x(value = 0, &block)
        return attributes[:geometry][:x] = block if block_given?

        Vedeu.log(out_of_bounds('x')) if x_out_of_bounds?(value)

        attributes[:geometry][:x] = value
      end

      # Define the starting y position (row/line) of the interface.
      #
      # @api public
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
      # @return [API::Interface]
      def y(value = 0, &block)
        return attributes[:geometry][:y] = block if block_given?

        Vedeu.log(out_of_bounds('y')) if y_out_of_bounds?(value)

        attributes[:geometry][:y] = value
      end

      # Define the number of characters/columns wide the interface will be.
      #
      # @api public
      # @param value [Fixnum]
      #
      # @example
      #   interface 'my_interface' do
      #     width 25
      #     ...
      #
      # @return [API::Interface]
      def width(value)
        Vedeu.log(out_of_bounds('width')) if x_out_of_bounds?(value)

        attributes[:geometry][:width] = value
      end

      # Define the number of characters/rows/lines tall the interface will be.
      #
      # @api public
      # @param value [Fixnum]
      #
      # @example
      #   interface 'my_interface' do
      #     height 8
      #     ...
      #
      # @return [API::Interface]
      def height(value)
        Vedeu.log(out_of_bounds('height')) if y_out_of_bounds?(value)

        attributes[:geometry][:height] = value
      end

      # Instructs Vedeu to calculate x and y geometry automatically based on the
      # centre character of the terminal, the width and the height.
      #
      # @api public
      # @param value [Boolean]
      #
      # @example
      #   interface 'my_interface' do
      #     centred true
      #     ...
      #
      # @return [API::Interface]
      def centred(value)
        unless value.is_a?(TrueClass) || value.is_a?(FalseClass)
          fail InvalidSyntax, 'Argument must be `true` or `false` for centred.'
        end

        attributes[:geometry][:centred] = value
      end

    end
  end
end
