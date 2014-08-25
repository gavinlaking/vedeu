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

  end
end
