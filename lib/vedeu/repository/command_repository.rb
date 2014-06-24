module Vedeu
  module CommandRepository
    extend Repository
    extend self

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

  # :nocov:
  module ClassMethods
    def command(name, entity, keypress = '', keyword = '')
      CommandRepository.create({
        name:     name,
        entity:   entity,
        keypress: keypress,
        keyword:  keyword
      })
    end
  end
  # :nocov:
end
