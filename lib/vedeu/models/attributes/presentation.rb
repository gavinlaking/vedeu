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

    private

    # @api private
    # @return [String]
    def parent_colour
      return '' if parent.nil?

      if parent.is_a?(Hash)
        ''

      else
        parent.colour.to_s

      end
    end

    # @api private
    # @return [String]
    def parent_style
      return '' if parent.nil?

      if parent.is_a?(Hash)
        ''

      else
        parent.style.to_s

      end
    end

    # @api private
    # @return [String]
    def render_colour(&block)
      [ colour.to_s, yield, parent_colour ].join
    end

    # @api private
    # @return [String]
    def render_style(&block)
      [ style.to_s, yield, parent_style ].join
    end

  end
end
