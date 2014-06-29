module Vedeu
  module Buffer
    class Composition
      include Virtus.model

      attribute :interface, Array[Buffer::Interface]

      def to_compositor
        interface.inject({}) do |acc, interface|
          acc[interface.name] = interface.to_compositor
          acc
        end
      end

      def to_hash
        Oj.load(to_json)
      end

      def to_json
        Oj.dump(attributes, mode: :compat, circular: true)
      end
    end
  end
end
