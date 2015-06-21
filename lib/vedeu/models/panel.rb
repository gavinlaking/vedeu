module Vedeu

  # Abstract interface class without the baggage.
  class Panel

    # @return [Vedeu::Panel]
    def initialize
    end

    private

    # @return [Vedeu::Area]
    def area
      @area = Vedeu::Area.from_dimensions(y_yn: y_yn, x_xn: x_xn)
    end

  end # Panel

end # Vedeu
