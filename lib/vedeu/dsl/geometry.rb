require 'vedeu/dsl/shared'

module Vedeu

  module DSL

    # Provide DSL methods for configuring the geometry of an interface.
    #
    class Geometry

      include Vedeu::DSL::Shared

      class << self

        def geometry(name, &block)
          unless block_given?
            fail InvalidSyntax, "'#{__callee__}' requires a block."
          end

          Vedeu::Geometry.build({ name: name }, &block).store
        end

      end

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
      #     geometry do
      #       centred!
      #
      #   interface 'my_interface' do
      #     geometry do
      #       centred false
      #       ...
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
      #     geometry do
      #       height 8
      #       ...
      #
      # @return [Fixnum]
      def height(value)
        model.height = value
      end

      # Specify the name of the interface for which the geometry belongs.
      #
      # @example
      #   interface 'my_interface' do
      #     geometry do
      #       name 'my_interface'
      #       ...
      #
      # @param value [String]
      # @return [String]
      def name(value)
        model.name = value
      end

      # Specify the number of characters/columns wide the interface will be.
      #
      # @param value [Fixnum]
      #
      # @example
      #   interface 'my_interface' do
      #     geometry do
      #       width 25
      #       ...
      #
      # @return [Fixnum]
      def width(value)
        model.width = value
      end

      # Specify the starting x position (column) of the interface.
      #
      # @param value [Fixnum]
      # @param block [Proc]
      #
      # @example
      #   interface 'my_interface' do
      #     geometry do
      #       x 7 # start on column 7.
      #
      #   interface 'other_interface' do
      #     geometry do
      #       x { use('my_interface').east } # start on column 8, if
      #                                      # `my_interface` changes position,
      #                                      # `other_interface` will too.
      #
      # @return [Fixnum]
      def x(value = 0, &block)
        return model.x = block if block_given?

        model.x = value
      end

      # Specify the starting y position (row/line) of the interface.
      #
      # @param value [Fixnum]
      # @param block [Proc]
      #
      # @example
      #   interface 'my_interface' do
      #     geometry do
      #       y  4
      #       ...
      #
      #   interface 'other_interface' do
      #     geometry do
      #       y  { use('my_interface').north } # start on row/line 3, if
      #       ...                              # `my_interface` changes position,
      #                                        # `other_interface` will too.
      #
      # @return [Fixnum]
      def y(value = 0, &block)
        return model.y = block if block_given?

        model.y = value
      end

      private

      attr_reader :model

    end # Geometry

  end # DSL

end # Vedeu
