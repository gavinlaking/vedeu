require_relative '../models/interface'
require_relative 'repository'

module Vedeu
  module Repositories
    module Interface
      extend Repository
      extend self

      def update(name, attributes = {})
        interface = query(:name, name)
        interface.attributes = attributes
        interface
      rescue EntityNotFound
        create(attributes)
      end

      def refresh
        by_layer.map { |interface| interface.refresh }.compact
      end

      def entity
        Vedeu::Interface
      end

      private

      def by_layer
        all.sort_by { |interface| interface.z }
      end
    end
  end
end
