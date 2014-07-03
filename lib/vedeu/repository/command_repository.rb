require_relative '../models/command'
require_relative 'repository'

module Vedeu
  module CommandRepository
    extend Repository
    extend self

    def by_input(input)
      return nil unless input

      by_keypress(input) || by_keyword(input)
    end

    def by_keypress(input)
      query(entity, :keypress, input)
    end

    def by_keyword(input)
      query(entity, :keyword, input)
    end

    def create(attributes)
      super(Command.new(attributes))
    end

    def entity
      Command
    end
  end
end
