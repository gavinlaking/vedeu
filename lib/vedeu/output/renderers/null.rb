module Vedeu

  # A renderer which returns nothing.
  #
  class Renderers::Null

    # @return [NilClass]
    def self.render(*)
      nil
    end

  end # Renderers::Null

end # Vedeu
