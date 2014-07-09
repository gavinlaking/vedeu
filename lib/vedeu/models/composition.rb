require 'oj'
require 'virtus'

require_relative 'interface_collection'

module Vedeu
  class Composition
    include Virtus.model

    attribute :interfaces, InterfaceCollection

    def self.enqueue(composition)
      new(composition).enqueue
    end

    def enqueue
      interfaces.map do |interface|
        interface.enqueue(interface.to_s)
        interface
      end

      self
    end

    def to_json
      Oj.dump(attributes, mode: :compat)
    end

    def to_s
      interfaces.map(&:to_s).join
    end
  end
end
