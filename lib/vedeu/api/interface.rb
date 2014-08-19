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

      def define(&block)
        instance_eval(&block) if block_given?

        Vedeu::Store.create(attributes)
      end

      def line(&block)
        attributes[:lines] << Line.build(&block)
      end

      def use(value)
        Vedeu.use(value)
      end

      def colour(value)
        attributes[:colour] = value
      end

      def cursor(value)
        attributes[:cursor] = value
      end

      def delay(value)
        attributes[:delay] = value
      end

      def group(value)
        attributes[:group] = value
      end

      def name(value)
        attributes[:name] = value
      end

      def x(value)
        fail XOutOfBounds if x_out_of_bounds?(value)

        attributes[:geometry][:x] = value
      end

      def y(value)
        fail YOutOfBounds if y_out_of_bounds?(value)

        attributes[:geometry][:y] = value
      end

      def width(value)
        fail InvalidWidth if x_out_of_bounds?(value)

        attributes[:geometry][:width] = value
      end

      def height(value)
        fail InvalidHeight if y_out_of_bounds?(value)

        attributes[:geometry][:height] = value
      end

      def centred(value)
        attributes[:geometry][:centred] = value
      end

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
