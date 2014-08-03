require 'vedeu/models/geometry'
require 'vedeu/support/interface_store'
require 'vedeu/support/terminal'

module Vedeu
  InvalidHeight = Class.new(StandardError)
  InvalidWidth  = Class.new(StandardError)
  OutOfBounds   = Class.new(StandardError)

  class InterfaceTemplate
    def self.save(name, &block)
      new(name).save(&block)
    end

    def initialize(name)
      @name = name.to_s
    end

    def save(&block)
      self.instance_eval(&block)

      InterfaceStore.create(attributes)
    end

    def x(value)
      fail OutOfBounds if value < 1 || value > Terminal.width

      attributes[:geometry][:x] = value
    end

    def y(value)
      fail OutOfBounds if value < 1 || value > Terminal.height

      attributes[:geometry][:y] = value
    end

    def width(value)
      fail InvalidWidth if value < 1 || value > Terminal.width

      attributes[:geometry][:width] = value
    end

    def height(value)
      fail InvalidHeight if value < 1 || value > Terminal.height

      attributes[:geometry][:height] = value
    end

    def centred(value)
      attributes[:geometry][:centred] = value
    end

    private

    attr_reader :name

    def attributes
      @attributes ||= { name: name, geometry: {} }
    end

    def method_missing(method_name, arg, &block)
      attributes[method_name] = arg
    end
  end
end
