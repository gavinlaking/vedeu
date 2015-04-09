require 'vedeu/geometry/geometry'
require 'vedeu/dsl/shared/all'

module Vedeu

  module DSL

    # Provide DSL methods for configuring the geometry of an interface.
    #
    class Geometry

      include Vedeu::DSL
      include Vedeu::DSL::Use

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
      def self.geometry(name, &block)
        fail InvalidSyntax, 'block not given' unless block_given?

        Vedeu::Geometry.build({ name: name }, &block).store
      end

      # Returns an instance of DSL::Geometry.
      #
      # @param model [Geometry]
      # @param client [Object]
      # @return [Vedeu::DSL::Geometry]
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
        boolean = value ? true : false

        model.centred = boolean
      end
      alias_method :centred!, :centred

      # Specify the number of characters/rows/lines tall the interface will be.
      #
      # @example
      #   geometry 'some_interface' do
      #     height 8
      #     # ...
      #
      # @note
      #   This value will be ignored if by `y` and `yn` are set.
      #
      # @param value [Fixnum]
      # @return [Fixnum]
      def height(value)
        model.height = value
      end

      # Use the geometry of another interface as the basis for the geometry you
      # are creating.
      #
      # @example
      #   geometry 'some_interface' do
      #     use 'other_interface' # will fetch the geometry of 'other_interface'
      #     # ...
      #
      #   geometry 'other_interface' do
      #     centred!
      #     height 4
      #     # ...
      #
      #   geometry 'some_interface' do
      #     use 'other_interface' # will fetch the geometry of 'other_interface'
      #     centred false
      #     # ...
      #
      # @note
      #   - When using 'use', the 'other_interface' (from the example) must
      #     already exist.
      #   - When using 'use', note that geometry defined before it's invocation
      #     will be overwritten by 'other_interface',
      #   - and geometry defined after will overwrite the inherited geometry.
      #   - Special geometry settings, like 'centred' also cause unexpected
      #     behaviour. If 'other_interface' was centred, then 'some_interface'
      #     will also be centred, to disable this, declare 'some_interface' to
      #     not be centred.
      #
      # @param name [String] The name of the interface you wish to use the
      #   geometry of.
      # @raise [ModelNotFound] When the geometry to be used does not exist yet.
      # @return [Vedeu::Geometry]
      # def use(name)
      #   if Vedeu.geometries.registered?(name)
      #     other = Vedeu.geometries.find(name).dup
      #     other.name = name
      #     @model = other
      #     @model.store

      #   else
      #     fail ModelNotFound, "Cannot use the geometry of '#{name}', as it " \
      #                         "is not yet defined."

      #   end
      # end

      # Specify the number of characters/columns wide the interface will be.
      #
      # @param value [Fixnum]
      #
      # @example
      #   geometry 'some_interface' do
      #     width 25
      #     # ...
      #
      # @note
      #   This value will be ignored if by `x` and `xn` are set.
      #
      # @return [Fixnum]
      def width(value)
        model.width = value
      end

      # Specify the starting x position (column) of the interface.
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
      # @param value [Fixnum]
      # @param block [Proc]
      # @return [Fixnum]
      def x(value = 1, &block)
        return model.x = block if block_given?

        model.x = value
      end

      # Specify the ending x position (column) of the interface.
      #
      # @example
      #   geometry 'some_interface' do
      #     xn 37 # end at column 37.
      #     # ...
      #
      #   geometry 'some_interface' do
      #     xn  { use('other_interface').right } # if `other_interface` changes
      #     # ...                                # position, `some_interface`
      #                                          # will too.
      #
      # @note
      #   This value will override `width`.
      #
      # @param value [Fixnum]
      # @param block [Proc]
      # @return [Fixnum]
      def xn(value = 1, &block)
        return model.xn = block if block_given?

        model.xn = value
      end

      # Specify the starting y position (row/line) of the interface.
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
      # @param value [Fixnum]
      # @param block [Proc]
      # @return [Fixnum]
      def y(value = 1, &block)
        return model.y = block if block_given?

        model.y = value
      end

      # Specify the ending y position (row/line) of the interface.
      #
      # @example
      #   geometry 'some_interface' do
      #     yn 24 # end at row 24.
      #     # ...
      #
      #   geometry 'some_interface' do
      #     yn { use('other_interface').bottom } # if `other_interface` changes
      #     # ...                                # position, `some_interface`
      #                                          # will too.
      #
      # @note
      #   This value will override `height`.
      #
      # @param value [Fixnum]
      # @param block [Proc]
      # @return [Fixnum]
      def yn(value = 1, &block)
        return model.yn = block if block_given?

        model.yn = value
      end

      private

      # @!attribute [r] client
      # @return [Object]
      attr_reader :client

      # @!attribute [r] model
      # @return [Geometry]
      attr_reader :model

    end # Geometry

  end # DSL

end # Vedeu
