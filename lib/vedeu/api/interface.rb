module Vedeu
  InvalidHeight = Class.new(StandardError)
  InvalidWidth  = Class.new(StandardError)
  XOutOfBounds  = Class.new(StandardError)
  YOutOfBounds  = Class.new(StandardError)

  module API
    class Interface
      def self.create(name, &block)
        new(name).create(&block)
      end

      def initialize(name)
        @name = name.to_s
      end

      def create(&block)
        instance_eval(&block) if block_given?

        stored_attributes = Store.create(attributes)

        interface = Vedeu::Interface.new(stored_attributes)

        Vedeu::Buffers.create(interface)

        interface
      end

      private

      attr_reader :name

      def use(value)
        Vedeu.use(value)
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

      def y_out_of_bounds?(value)
        value < 1 || value > Terminal.height
      end

      def x_out_of_bounds?(value)
        value < 1 || value > Terminal.width
      end

      def method_missing(method_name, arg, &block)
        attributes[method_name] = arg
      end

      def attributes
        @attributes ||= { name: name, geometry: {} }
      end
    end
  end
end
