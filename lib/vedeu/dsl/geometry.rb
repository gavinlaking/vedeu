module Vedeu

  module DSL

    class Geometry

      # Returns an instance of DSL::Geometry.
      #
      # @param model [Geometry]
      def initialize(model)
        @model = model
      end

      # Instructs Vedeu to calculate x and y geometry automatically based on the
      # centre character of the terminal, the width and the height.
      #
      # @param value [Boolean] Any value other than nil or false will evaluate
      #   to true.
      #
      # @example
      #   interface 'my_interface' do
      #     centred!
      #
      #   interface 'my_interface' do
      #     centred false
      #     ...
      #
      # @return [Boolean]
      def centred(value = true)
        model.centred = !!value
      end
      alias_method :centred!, :centred

      # Specify the number of characters/rows/lines tall the interface will be.
      #
      # @param value [Fixnum]
      #
      # @example
      #   interface 'my_interface' do
      #     height 8
      #     ...
      #
      # @return [Fixnum]
      def height(value)
        Vedeu.log(out_of_bounds('height')) if y_out_of_bounds?(value)

        model.height = value
      end

      # Specify the number of characters/columns wide the interface will be.
      #
      # @param value [Fixnum]
      #
      # @example
      #   interface 'my_interface' do
      #     width 25
      #     ...
      #
      # @return [Fixnum]
      def width(value)
        Vedeu.log(out_of_bounds('width')) if x_out_of_bounds?(value)

        model.width = value
      end

      # Specify the starting x position (column) of the interface.
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
      # @return [Fixnum]
      def x(value = 0, &block)
        return model.x = block if block_given?

        Vedeu.log(out_of_bounds('x')) if x_out_of_bounds?(value)

        model.x = value
      end

      # Specify the starting y position (row/line) of the interface.
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
      # @return [Fixnum]
      def y(value = 0, &block)
        return model.y = block if block_given?

        Vedeu.log(out_of_bounds('y')) if y_out_of_bounds?(value)

        model.y = value
      end

      private

      attr_reader :model

    end # Geometry

  end # DSL

end # Vedeu
