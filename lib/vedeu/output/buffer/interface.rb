module Vedeu
  module Buffer
    class Interface
      include Virtus.model

      attribute :name, String
      attribute :line, Array[Buffer::Line]

      def to_compositor
        line.map(&:to_compositor)
      end
    end
  end
end
