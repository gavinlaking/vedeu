require 'vedeu/support/geometry'
require 'vedeu/support/interface_store'

module Vedeu
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

    private

    attr_reader :name

    def overrides
      @overrides = if user_attributes[:centred] == true
        { x: geometry.left, y: geometry.top }
      else
        {}
      end
    end

    def geometry
      @_geometry ||= Geometry.new({
        height: user_attributes[:height],
        width:  user_attributes[:width],
      })
    end

    def attributes
      user_attributes.merge!(overrides)
    end

    def user_attributes
      @attributes ||= { name: name }
    end

    def method_missing(method_name, arg, &block)
      user_attributes[method_name] = arg
    end
  end
end
