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

      def entity
        Vedeu::Interface
      end
    end
  end
end
