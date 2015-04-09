module Vedeu

  # Allows the storing of interface/view borders independent of the interface
  # instance.
  #
  class Borders < Repository

    # @return [Vedeu::Borders]
    def self.borders
      @borders ||= reset! # Vedeu::Borders.new(Vedeu::Border)
    end

    # @return [Vedeu::Borders]
    def self.repository
      Vedeu.borders
    end

    # @return [Vedeu::Borders]
    def self.reset!
      @borders = Vedeu::Borders.register_repository(Vedeu::Border)
    end

    # @param name [String] The name of the stored border.
    # @return [Vedeu::Border|Vedeu::NullBorder|NilClass]
    def by_name(name)
      if registered?(name)
        find(name)

      elsif Vedeu.interfaces.registered?(name)
        interface = Vedeu.interfaces.find(name)
        Vedeu::NullBorder.new(interface)

      end
    end

  end # Borders

end # Vedeu
