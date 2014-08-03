require 'vedeu/support/esc'
require 'vedeu/models/colour'

# Todo: style method (actually whole thing)

module Vedeu
  module Helpers
    def line(&block)
      block.call.gsub(/\n/, '')
    end

    def foreground(value, &block)
      output = Esc.foreground_colour(value)

      if block_given?
        output << block.call
        output << Esc.string('fg_reset')
      end

      output
    end
    alias_method :fg, :foreground

    def background(value, &block)
      output = Esc.background_colour(value)

      if block_given?
        output << block.call
        output << Esc.string('bg_reset')
      end

      output
    end
    alias_method :bg, :background

    def colour(attributes = {}, &block)
      output = Colour.new(attributes).to_s

      if block_given?
        output << block.call
        output << Esc.string('colour_reset')
      end

      output
    end

    def style(*value_or_values, &block)
      if value_or_values.one?
        output = Esc.string(value_or_values.first)
      else
        output = value_or_values.map do |s|
          Esc.string(s)
        end.join
      end

      if block_given?
        output << block.call
        output << Esc.string('reset')
      end

      output
    end
  end
end
