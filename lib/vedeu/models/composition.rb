module Vedeu
  class Composition
    include Virtus.model

    attribute :interfaces, InterfaceCollection

    def to_s
      interfaces.map(&:to_s).join
    end
  end
end
