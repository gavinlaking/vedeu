require 'vedeu/models/geometry'
require 'vedeu/api/grid'
require 'vedeu/api/store'
require 'vedeu/support/terminal'

module Vedeu
  module API
    InvalidHeight = Class.new(StandardError)
    InvalidWidth  = Class.new(StandardError)
    XOutOfBounds  = Class.new(StandardError)
    YOutOfBounds  = Class.new(StandardError)

    def interface(name, &block)
      Interface.save(name, &block)
    end

    class Interface
      def self.save(name, &block)
        new(name).save(&block)
      end

      def initialize(name)
        @name = name.to_s
      end

      def save(&block)
        self.instance_eval(&block) if block_given?

        stored_attributes = Store.create(attributes)

        Vedeu::Interface.new(stored_attributes)
      end

      private

      attr_reader :name

      def use(value)
        Vedeu.use(value)
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

      def attributes
        @attributes ||= { name: name, geometry: {} }
      end

      def method_missing(method_name, arg, &block)
        attributes[method_name] = arg
      end

      def y_out_of_bounds?(value)
        value < 1 || value > Terminal.height
      end

      def x_out_of_bounds?(value)
        value < 1 || value > Terminal.width
      end
    end
  end
end
