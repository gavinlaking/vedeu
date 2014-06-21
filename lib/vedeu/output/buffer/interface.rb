module Vedeu
  module Buffer
    class Interface
      include Virtus.model

      attribute :name, String
      attribute :line, Array[Buffer::Line]
    end
  end
end
