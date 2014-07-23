module Vedeu
  module Repositories
    class Storage
      def initialize
        @store = {}
      end

      def create(entity, attributes)
        entities(entity)
          .store(attributes[:name], entity.new(attributes))
      end

      def all(entity = nil)
        return entities unless entity

        entities(entity).values
      end

      def query(entity, attribute, value)
        return false if value.nil? || value.empty?

        entities(entity).select do |name, result|
          return result if result.send(attribute) == value
        end

        false
      end

      def reset(entity)
        store[entity.to_s] = {}
      end

      private

      attr_reader :store

      def entities(entity)
        store[entity.to_s] ||= {}
      end
    end
  end
end
