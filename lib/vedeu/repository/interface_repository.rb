module Vedeu
  class UndefinedInterface < StandardError; end

  class InterfaceRepository
    extend Repository

    class << self
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
        all.sort_by { |interface| interface.layer }
      end

      def entity
        Interface
      end
    end
  end

  # :nocov:
  module ClassMethods
    def interface(name, options = {})
      interface_name = name.is_a?(Symbol) ? name.to_s : name

      InterfaceRepository.create({
        name: interface_name
      }.merge!(options))
    end
  end

  def self.included(receiver)
    receiver.extend(ClassMethods)
  end
  # :nocov:
end
