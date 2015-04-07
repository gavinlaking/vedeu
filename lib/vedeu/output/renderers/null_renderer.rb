module Vedeu

  # A renderer which returns nothing.
  #
  class NullRenderer

    # @return [NilClass]
    def self.render(*)
      nil
    end

  end # NullRenderer

end # Vedeu
