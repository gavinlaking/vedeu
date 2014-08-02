require 'virtus'

require 'vedeu/models/attributes/interface_collection'

# Todo: mutation (interfaces)

module Vedeu
  class Composition
    include Virtus.model

    attribute :interfaces, InterfaceCollection

    def self.enqueue(attributes)
      new(attributes).enqueue
    end

    def enqueue
      interfaces.map { |interface| interface.enqueue }
    end

    def to_s
      interfaces.map(&:to_s).join
    end
  end
end
