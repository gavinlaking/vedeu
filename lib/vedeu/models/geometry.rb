require 'virtus'

require 'vedeu/support/esc'
require 'vedeu/support/terminal'

module Vedeu
  class Geometry
    include Virtus.model

    attribute :y,       Integer, default: 1
    attribute :x,       Integer, default: 1
    attribute :width,   Integer, default: Terminal.width
    attribute :height,  Integer, default: Terminal.height
    attribute :centred, Boolean, default: false

    def origin(index = 0)
      Esc.set_position(virtual_y[index], left)
    end

    def top
      if centred
        centre_y - (height / 2)
      else
        y
      end
    end

    def left
      if centred
        centre_x - (width / 2)
      else
        x
      end
    end

    def bottom
      top + height
    end

    def right
      left + width
    end

    def position
      {
        y:       top,
        x:       left,
        height:  height,
        width:   width,
        centred: centred,
        top:     top,
        bottom:  bottom,
        left:    left,
        right:   right,
      }
    end

    private

    def centre
      @_centre ||= Terminal.centre
    end

    def centre_y
      centre.first
    end

    def centre_x
      centre.last
    end

    def virtual_y
      @_virtual_y ||= (top..bottom).to_a
    end
  end
end
