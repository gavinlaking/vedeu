require_relative '../colour'
require_relative '../../support/coordinate'
require_relative '../../repository/interface_repository'

module Vedeu
  class InterfaceBuilder
    def self.build(name, &block)
      new(name).build(&block)
    end

    def initialize(name)
      @name = name.to_s
    end

    def build(&block)
      self.instance_eval(&block)

      InterfaceRepository.create(attributes)
    end

    private

    attr_reader :name

    def attributes
      user_attributes.merge!(overrides)
    end

    def overrides
      @overrides = if user_attributes[:centred] == true
        { x: geometry.left, y: geometry.top }
      else
        {}
      end
    end

    def geometry
      @_geometry ||= Coordinate.new({
        height: user_attributes[:height],
        width:  user_attributes[:width],
      })
    end

    def user_attributes
      @attributes ||= { name: name, centred: false }
    end

    def method_missing(method_name, arg, &block)
      user_attributes[method_name] = arg
    end
  end
end
