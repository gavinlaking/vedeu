module Vedeu
  module Presentation

    # @return [Colour]
    def colour
      @colour ||= Colour.new(attributes[:colour])
    end

    # @return [Style]
    def style
      @style ||= Style.new(attributes[:style])
    end

    # @return [String]
    def to_s
      render_colour do
        render_style do
          data
        end
      end
    end
    alias_method :render, :to_s

    private

    # @api private
    # @return [String]
    def parent_colour
      return parent.colour.render unless parent.nil?

      ''
    end

    # @api private
    # @return [String]
    def parent_style
      return parent.style.render unless parent.nil?

      ''
    end

    # @api private
    # @return [String]
    def render_colour(&block)
      [ colour.render, yield, parent_colour ].join
    end

    # @api private
    # @return [String]
    def render_style(&block)
      [ style.render, yield, parent_style ].join
    end

  end
end
