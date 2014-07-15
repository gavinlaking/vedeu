require_relative '../models/interface'
require_relative 'repository'

module Vedeu
  class UndefinedInterface < StandardError; end

  module InterfaceRepository
    extend Repository
    extend self

    def create(attributes = {})
      super(entity.new(attributes))
    end

    def find(name)
      result = super
      fail UndefinedInterface, "#{name.to_s} could not be found." unless result
      result
    end

    def update(name, attributes = {})
      interface = find(name)
      interface.attributes = attributes
      interface
    rescue UndefinedInterface
      create(attributes)
    end

    def refresh
      by_layer.map { |interface| interface.refresh }.compact
    end

    def entity
      Interface
    end

    private

    def by_layer
      all.sort_by { |interface| interface.z }
    end
  end
end
