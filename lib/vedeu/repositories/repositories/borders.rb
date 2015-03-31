module Vedeu

  # Allows the storing of interface/view borders independent of the interface
  # instance.
  #
  class Borders < Repository

    # @return [Vedeu::Borders]
    def self.borders
      @borders ||= reset! # Vedeu::Borders.new(Vedeu::Border)
    end

    def self.repository
      Vedeu.borders
    end

    def self.reset!
      @borders = Vedeu::Borders.register_repository(Vedeu::Border)
    end

  end # Borders

end # Vedeu
