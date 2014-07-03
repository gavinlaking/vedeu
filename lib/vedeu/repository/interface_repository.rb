require_relative '../models/interface'
require_relative 'repository'

module Vedeu
  class UndefinedInterface < StandardError; end

  module InterfaceRepository
    extend Repository
    extend self

    def create(attributes = {})
      super(Interface.new(attributes))
    end

    def find(name)
      result = super
      raise UndefinedInterface unless result
      result
    end

    def refresh
      by_layer.map { |interface| interface.refresh }.compact
    end

    def by_layer
      all.sort_by { |interface| interface.z }
    end

    def entity
      Interface
    end
  end
end
