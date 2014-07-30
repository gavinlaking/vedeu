require 'vedeu/support/esc'

module Vedeu
  module Helpers
    def foreground(value, &block)
      @output = ''
      @output << Esc.foreground_colour(value)
      @output << block.call if block_given?
      @output
    end
    alias_method :fg, :foreground

    def background(value, &block)
      @output = ''
      @output << Esc.background_colour(value)
      @output << block.call if block_given?
      @output
    end
    alias_method :bg, :background

    def colour(attributes = {}, &block)
      @output = ''
      @output << Colour.new(attributes).to_s
      @output << block.call if block_given?
      @output
    end

    def style(*value_or_values, &block)
      @output = ''
      if value_or_values.one?
        @output << Esc.string(value_or_values.first)
        @output << block.call if block_given?
      else
        @output << value_or_values.map do |s|
          Esc.string(s)
        end.join
        @output << block.call if block_given?
      end
      @output
    end
  end
end
