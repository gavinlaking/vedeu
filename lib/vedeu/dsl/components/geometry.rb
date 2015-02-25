require 'vedeu/models/geometry'
require 'vedeu/dsl/shared/all'

module Vedeu

  module DSL

    # Provide DSL methods for configuring the geometry of an interface.
    #
    class Geometry

      include Vedeu::DSL
      include Vedeu::DSL::Use

      class << self

        # Specify the geometry of an interface or view with a simple DSL.
        #
        # @example
        #   Vedeu.geometry 'some_interface' do
        #     # ...
        #
        # @param name [String] The name of the interface or view to which this
        #   geometry belongs.
        # @param block [Proc]
        # @raise [InvalidSyntax] The required block was not given.
        # @return [Vedeu::Geometry]
        def geometry(name, &block)
          fail InvalidSyntax, 'block not given' unless block_given?

          Vedeu::Geometry.build({ name: name }, &block).store
        end

      end

      # Returns an instance of DSL::Geometry.
      #
      # @param model [Geometry]
      def initialize(model, client = nil)
        @model  = model
        @client = client
      end

      # Instructs Vedeu to calculate x and y geometry automatically based on the
      # centre character of the terminal, the width and the height.
      #
      # @param value [Boolean] Any value other than nil or false will evaluate
      #   to true.
      #
      # @example
      #   geometry 'some_interface' do
      #     centred!
      #     # ...
      #
      #   geometry 'some_interface' do
      #     centred false
      #     # ...
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
      #   geometry 'some_interface' do
      #     height 8
      #     # ...
      #
      # @return [Fixnum]
      def height(value)
        model.height = value
      end

      # Specify the number of characters/columns wide the interface will be.
      #
      # @param value [Fixnum]
      #
      # @example
      #   geometry 'some_interface' do
      #     width 25
      #     # ...
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
      #   geometry 'some_interface' do
      #     x 7 # start on column 7.
      #     # ...
      #
      #   geometry 'some_interface' do
      #     x { use('other_interface').east } # start on column 8, if
      #     # ...                             # `other_interface` changes
      #                                       # position, `some_interface` will
      #                                       # too.
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
      #   geometry 'some_interface' do
      #     y  4
      #     # ...
      #
      #   geometry 'some_interface' do
      #     y  { use('other_interface').north } # start on row/line 3, if
      #     # ...                               # `other_interface` changes
      #                                         # position, `some_interface`
      #                                         # will too.
      #
      # @return [Fixnum]
      def y(value = 0, &block)
        return model.y = block if block_given?

        model.y = value
      end

      private

      attr_reader :client, :model

    end # Geometry

  end # DSL

end # Vedeu
