require 'json'
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
      json_attributes.to_json
    end

    def to_s
      interfaces.map(&:to_s).join
    end

    private

    def json_attributes
      {
        interfaces: interfaces
      }
    end
  end
end
