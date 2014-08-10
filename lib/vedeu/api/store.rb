require 'vedeu/models/interface'

# Todo: mutation (persistence)

module Vedeu
  module API
    EntityNotFound = Class.new(StandardError)

    def use(name)
      Vedeu::Interface.new(Store.query(name))
    end

    module Store
      extend self

      def create(attributes)
        storage.store(attributes[:name], attributes)
      end

      def query(name)
        attributes = storage.fetch(name) do
          fail EntityNotFound, 'Interface was not found.'
        end
      end

      def reset
        @storage = {}
      end

      private

      def storage
        @storage ||= {}
      end
    end
  end
end
