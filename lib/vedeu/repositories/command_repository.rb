require_relative '../models/command'
require_relative 'repository'

module Vedeu
  module Repositories
    module Command
      extend Repository
      extend self

      def by_input(input)
        by_keypress(input) || by_keyword(input)
      end

      def entity
        Vedeu::Command
      end

      private

      def by_keypress(input)
        query(:keypress, input)
      rescue EntityNotFound
        false
      end

      def by_keyword(input)
        query(:keyword, input)
      rescue EntityNotFound
        false
      end
    end
  end
end
