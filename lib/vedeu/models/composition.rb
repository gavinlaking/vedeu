module Vedeu
  class Composition
    include Virtus.model

    attribute :interfaces, InterfaceCollection

    def self.enqueue(attributes)
      new(attributes).enqueue
    end

    def enqueue
      interfaces.map do |interface|
        Buffers.enqueue(interface.name, interface.to_s)
      end
    end

    def to_s
      interfaces.map(&:to_s).join
    end
  end
end
