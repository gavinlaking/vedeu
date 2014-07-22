require_relative 'builder'
require_relative '../../support/coordinate'
require_relative '../../repository/interface_repository'

module Vedeu
  class InterfaceBuilder < Builder
    def repository
      InterfaceRepository
    end

    private

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

    def method_missing(method_name, arg, &block)
      user_attributes[method_name] = arg
    end
  end
end
