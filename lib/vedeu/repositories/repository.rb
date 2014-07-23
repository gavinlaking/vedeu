require_relative 'storage'

module Vedeu
  EntityNotFound = Class.new(StandardError)

  module Repositories
    module Repository
      extend self

      def create(attributes)
        storage.create(entity, attributes)
      end

      def all
        storage.all(entity)
      end

      def query(attribute, value)
        if result = storage.query(entity, attribute, value)
          result

        else
          fail EntityNotFound, "#{entity.to_s} could not be found."

        end
      end

      def reset
        storage.reset(entity)
      end

      def entity
        fail StandardError, 'The extending module implements this.'
      end

      private

      def storage
        @storage ||= Storage.new
      end
    end
  end
end
