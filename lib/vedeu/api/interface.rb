module Vedeu
  InvalidHeight = Class.new(StandardError)
  InvalidWidth  = Class.new(StandardError)
  XOutOfBounds  = Class.new(StandardError)
  YOutOfBounds  = Class.new(StandardError)

  module API
    class Interface < Vedeu::Interface
      def self.build(attributes = {}, &block)
        new(attributes, &block).attributes
      end

      def self.define(attributes = {}, &block)
        new(attributes).define(&block)
      end

      def initialize(attributes = {}, &block)
        @attributes = attributes

        if block_given?
          @self_before_instance_eval = eval('self', block.binding)

          instance_eval(&block)
        end
      end

      # @param block [Proc]
      def define(&block)
        instance_eval(&block) if block_given?

        Vedeu::Store.create(attributes)
      end

      # @param block [Proc]
      def line(&block)
        attributes[:lines] << Line.build(&block)
      end

      # @param value [String]
      def use(value)
        Vedeu.use(value)
      end

      # @param value [Hash]
      def colour(value)
        attributes[:colour] = value
      end

      # @param value [Boolean]
      def cursor(value)
        attributes[:cursor] = value
      end

      # @param value [Fixnum|Float]
      def delay(value)
        attributes[:delay] = value
      end

      # @param value [String]
      def group(value)
        attributes[:group] = value
      end

      # @param value [String]
      def name(value)
        attributes[:name] = value
      end

      # @param value [Fixnum]
      def x(value)
        fail XOutOfBounds if x_out_of_bounds?(value)

        attributes[:geometry][:x] = value
      end

      # @param value [Fixnum]
      def y(value)
        fail YOutOfBounds if y_out_of_bounds?(value)

        attributes[:geometry][:y] = value
      end

      # @param value [Fixnum]
      def width(value)
        fail InvalidWidth if x_out_of_bounds?(value)

        attributes[:geometry][:width] = value
      end

      # @param value [Fixnum]
      def height(value)
        fail InvalidHeight if y_out_of_bounds?(value)

        attributes[:geometry][:height] = value
      end

      # @param value [Boolean]
      def centred(value)
        attributes[:geometry][:centred] = value
      end

      # @param value [Array|String]
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
