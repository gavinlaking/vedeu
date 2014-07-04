require 'oj'
require 'virtus'

require_relative 'interface_collection'

module Vedeu
  class Composition
    include Virtus.model

    class << self
      def enqueue(composition)
        new(composition).enqueue
      end
    end

    attribute :interfaces, InterfaceCollection

    def enqueue
      interfaces.map do |interface|
        interface.enqueue(interface.to_s)
      end
    end

    def to_json
      Oj.dump(attributes, mode: :compat)
    end

    def to_s
      interfaces.map(&:to_s).join
    end
  end
end
