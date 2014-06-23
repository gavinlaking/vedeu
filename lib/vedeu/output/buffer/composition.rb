module Vedeu
  module Buffer
    class Composition
      include Virtus.model

      attribute :interface, Array[Buffer::Interface]
    end
  end
end
