require 'virtus'

require_relative 'presentation'
require_relative 'line'
require_relative '../support/position'
require_relative '../support/cursor'
require_relative '../support/queue'
require_relative '../support/terminal'

module Vedeu
  class Interface
    include Virtus.model
    include Presentation
    include Vedeu::Queue

    attribute :name,    String
    attribute :lines,   Array[Line]
    attribute :y,       Integer, default: 1
    attribute :x,       Integer, default: 1
    attribute :z,       Integer, default: 1
    attribute :width,   Integer, default: Terminal.width
    attribute :height,  Integer, default: Terminal.height

    def clear(index = 0)
      [origin(index), (' ' * width), origin(index)].join
    end

    def current
      @current || []
    end

    def current=(value)
      @current = value
    end

    def cursor
      @cursor.nil? ? true : @cursor
    end

    def cursor=(value)
      @cursor = value
    end

    def dy
      clip_y? ? defaults[:height] : (y + height)
    end

    def dx
      clip_x? ? defaults[:width] : (x + width)
    end

    def origin(index = 0)
      Position.set(virtual_y(index), virtual_x)
    end

    def refresh
      if enqueued?
        current = dequeue
      elsif current.nil? || current.empty?
        current = clear_interface
      else
        current
      end
    end

    # def to_compositor
    #   line.map(&:to_compositor)
    # end

    def to_json
      Oj.dump(attributes, mode: :compat)
    end

    def to_s
      [
        clear_interface,
        origin,
        colour.to_s,
        lines.map(&:to_s)
      ].join
    end

    def virtual_x(index = 0)
      ((x..dx).to_a)[index]
    end

    def virtual_y(index = 0)
      ((y..dy).to_a)[index]
    end

    private

    def clear_interface
      [
        colour.to_s,
        height.times.inject([]) { |acc, i| acc << clear(i) }
      ].join
    end

    def clip_y?
      ((y + height) > defaults[:height])
    end

    def clip_x?
      ((x + width) > defaults[:width])
    end

    def defaults
      {
        width:  Terminal.width,
        height: Terminal.height
      }
    end
  end
end
